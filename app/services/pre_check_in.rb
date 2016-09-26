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
        
        EnrollPatron.start( phone_number: message.sender_local_part, patronage_proof:  )
        
        PatronEnrollmentMailer.provide_name(message.sender).deliver_now
      
      when patron.pending
        #Finish sms_enrollment(patron: patron, full_name: message.body)
      else
        process_stamp(patron, store)
      end

    end

    def enroll_patron_params(message)
      params = { phone_number: message.sender_local_part }
      params << { patronage_proofs: { code: message.body_text_part} } if message.body_text_part
    end

  end
end