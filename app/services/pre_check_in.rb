#This module contains Interactors for processing check ins from different
# media types.  It parses the check in message and then forwards the information
# on to a different service to finish the enrollment, apply the stamp, etc. 
module PreCheckIn
  class SMSCheckIn
    def initialize(check_in_message, email_of_store)
      Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: email_of_store -> #{email_of_store}"
      
      store = Store.find_by_email_for_check_ins(email_of_store)
      
      message = ParseEmailMessage.new(check_in_message)
      patron = Patron.find_by_digit_only_phone_number(message.sender_local_part)
      case 
      when patron.nil?
        Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: enroll_patron #{message.sender} "
        
        patron = EnrollPatron.start( patron_params(message) )
        CheckIn.create( check_in_params(patron: patron, store: store, message: message) )
      
      when patron.pending
        #Finish sms_enrollment(patron: patron, full_name: message.body)
        Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: finalize enrollment for #{patron.digit_only_phone_number}"
        EnrollPatron.finish(patron_to_finish: patron, enrollment_message: message)
        
        file_name_of_card = ApplyStampService.new(patron: patron, store: store, check_in: nil).file_name_of_card
        LoyaltyCardMailer.stamped_card(patron.sms_address, file_name_of_card).deliver_now

      else
        Rails.logger.info " #{self.class.to_s}##{__method__.to_s} check in for existing patron."
        check_in = CheckIn.create( check_in_params(patron: patron, store: store, message: message) )
        stamp_service = ApplyStampService.new(patron: patron, store: store, check_in: check_in)
        
        RedemptionMailer.link(patron.sms_address, stamp_service.redemption_link).deliver_now if stamp_service.full_card?
        LoyaltyCardMailer.stamped_card(patron.sms_address, stamp_service.file_name_of_card).deliver_now
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

  class WebCheckIn

  end
end