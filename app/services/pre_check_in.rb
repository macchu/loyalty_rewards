#This module contains Interactors for processing check ins.
#  There are a lot of different 
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
        
        PatronEnrollmentMailer.provide_name(message.sender).deliver_now #TODO: move this inside EnrollPatron.

        CheckIn.create( check_in_params(patron: patron, store: store, message: message)  )
      when patron.pending
        #Finish sms_enrollment(patron: patron, full_name: message.body)
      else
        process_stamp(patron, store)
      end

    end

    private 
    def patron_params(message)
      params = { phone_number: message.sender_local_part, pending: true }
      
    end

    def check_in_params(patron:, store:, message: )
      params = { patron_id: patron.id, store_id: store.id, phone_number: patron.phone_number }
      #TODO: Account for texted codes or pictures of receipts.
      params[:patronage_proof_attributes] = { code: message.body_text_part} if message.body_text_part
      return params
    end

  end
end