#This module contains Interactors for processing check ins from different
# media types.  It parses the check in message and then forwards the information
# on to a different service to finish the enrollment, apply the stamp, etc.
#
#This module should reflect the responsibilities of a controller. 
#
# REFACTOR: 
#   1) DRY up this code.
#   2) Rename PreCheckIn to CheckInService or something similar.
#   3) @response_content = "..." should be defined by the customer in an admin page.

module PreCheckIn
  class SMSCheckIn
    def initialize(check_in_message, email_of_store)
      Benchmark.bm(5) do |x|
        x.report("setup:") {
          Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: email_of_store -> #{email_of_store}"
          
          store = Store.find_by_email_for_check_ins(email_of_store)
          
          message = ParseEmailMessage.new(check_in_message)
          patron = Patron.find_by_digit_only_phone_number(message.sender_local_part)
          case 
          when patron.nil?
            Benchmark.measure("new:") {
              Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: enroll_patron #{message.sender} "
              patron = EnrollPatron.start( patron_params(message) )
              CheckIn.create( check_in_params(patron: patron, store: store, message: message) )
              #TODO: Link Patrons & Stores here.
              PatronStore.create(patron: patron, store: store)
            }
          when patron.pending
            Benchmark.measure("pending:") {
              #Finish sms_enrollment(patron: patron, full_name: message.body)
              Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: finalize enrollment for #{patron.digit_only_phone_number}"
              EnrollPatron.finish(patron_to_finish: patron, enrollment_message: message)
              
              file_name_of_card = ApplyStampService.new(patron: patron, store: store, check_in: nil).file_name_of_card
              LoyaltyCardMailer.stamped_card(patron.sms_address, file_name_of_card).deliver_now
            }
          else
            Benchmark.measure("stamp:") {
              Rails.logger.info " #{self.class.to_s}##{__method__.to_s} check in for existing patron."
              Rails.logger.info "patron: #{patron.full_name}"
              Rails.logger.info "store: #{store.name}"
              Rails.logger.info "message: #{message}"
              
              check_in = CheckIn.create( check_in_params(patron: patron, store: store, message: message) )
              stamp_service = ApplyStampService.new(patron: patron, store: store, check_in: check_in, is_demo: message.is_demo)
              LoyaltyCardMailer.stamped_card(patron.sms_address, stamp_service.file_name_of_card).deliver_now

              #Send reward redemption code if card is full.
              Rails.logger.info "stamp_service.full_card?: #{stamp_service.full_card}"
              RedemptionMailer.send_link(patron.sms_address, stamp_service.redemption_url).deliver_now if stamp_service.full_card
            }
          end
        }
      end
    end

    private 
    def patron_params(message)
      params = { phone_number: message.sender_local_part, sms_address: message.sender, pending: true }
    end

    def check_in_params(patron:, store:, message: )
      params = { patron_id: patron.id, store_id: store.id, phone_number: patron.phone_number }
      #TODO: Account for texted codes or pictures of receipts.
      params[:patronage_proof_attributes] = { code: message.body_text_part} if message.body_text_part
      return params
    end
  end

  class TwilioCheckIn
    attr_reader :response_content
    attr_reader :file_name_of_card
    attr_reader :redemption_message
    attr_reader :new_patron

    def initialize(twilio_params)
      Rails.logger.info " #{self.class.to_s}##{__method__.to_s}:"
      store = Store.find_by_twilio_phone_number(twilio_params["To"].gsub(/\D/, ''))
      patron = Patron.find_by_digit_only_phone_number( twilio_params["From"].gsub(/\D/, '') )
      case 
      when patron.nil?
        Rails.logger.info "#{self.class.to_s}##{__method__.to_s} new patron branch: enroll_patron #{twilio_params["From"]} "
        patron = Patron.create(phone_number: twilio_params["From"], pending: true )

        Rails.logger.info "#{self.class.to_s}##{__method__.to_s} new patron branch: Create check in for: patron #{patron.id} @ store #{store.id}"
        check_in_params = { patron: patron, store: store, phone_number: twilio_params["From"] }
        check_in_params[:patronage_proof_attributes] = { code: twilio_params["Body"]}

        CheckIn.create( check_in_params )
        PatronStore.create(patron: patron, store: store)
        
        if store.demo
          # Demo users receive a punch card immediately. Do not ask them their name!
          Rails.logger.info "#{self.class.to_s}##{__method__.to_s} new patron branch DEMO branch: enroll_patron #{twilio_params["From"]} "
          patron.finish_enrollment("Demo", "User")
          @file_name_of_card = ApplyStampService.new(patron: patron, store: store, check_in: nil).file_name_of_card
          @response_content = "Thanks! Send one more text to see an award code."
          Rails.logger.info "#{self.class.to_s}##{__method__.to_s} new patron DEMO branch: finished."
        else
          # Ask new users for their first and last name. Possibly a bad idea. 
          @response_content = "Hi. To enroll you I need your first and last name."
          @new_patron = true
          Rails.logger.info "#{self.class.to_s}##{__method__.to_s} new patron branch: finished."
        end
      when patron.pending
        Rails.logger.info "#{self.class.to_s}##{__method__.to_s}: finalize enrollment for #{patron.digit_only_phone_number}"
        parsed_name = Namae.parse(twilio_params["Body"])
        if parsed_name.empty?
          Rails.logger.error "#{self.class.to_s}##{__method__.to_s}: failed to parse name from body #{twilio_params["Body"]} for patron #{patron.phone_number}"
        else
          Rails.logger.info "#{self.class.to_s}##{__method__.to_s}: extracted name #{parsed_name.first}"
          patron.finish_enrollment(parsed_name.first.given, parsed_name.first.family)
              
          @file_name_of_card = ApplyStampService.new(patron: patron, store: store, check_in: nil).file_name_of_card

          @response_content = "Thanks! For demonstration purposes send one more text message to fill the card so you can redeem it for a 'reward'."
        end
        #LoyaltyCardMailer.stamped_card(patron.sms_address, file_name_of_card).deliver_now
      else
        Rails.logger.info " #{self.class.to_s}##{__method__.to_s} check in for existing patron."
        Rails.logger.info "patron: #{patron.full_name}"
        Rails.logger.info "store: #{store.name}"
        Rails.logger.info "message: #{twilio_params["Body"]}"
        check_in_params = { patron: patron, store: store, phone_number: twilio_params["From"] }
        check_in_params[:patronage_proof_attributes] = { code: twilio_params["Body"]}
        check_in = CheckIn.create( check_in_params )
        stamp_service = ApplyStampService.new(patron: patron, store: store, check_in: check_in, is_demo: false)

        @file_name_of_card = stamp_service.file_name_of_card
        
        if stamp_service.full_card
          @response_content = "Here you go.  Click this link for your redemption: #{stamp_service.redemption_url}"
        else
          @response_content = "Got it!  For demonstration purposes send one more text message to fill the card so you can redeem it for a 'reward'."
        end
        # LoyaltyCardMailer.stamped_card(patron.sms_address, stamp_service.file_name_of_card).deliver_now

        # #Send reward redemption code if card is full.
        Rails.logger.info "stamp_service.full_card?: #{stamp_service.full_card}"

        # RedemptionMailer.send_link(patron.sms_address, stamp_service.redemption_url).deliver_now if stamp_service.full_card
      end
    end
  end

  class WebCheckIn

  end
end