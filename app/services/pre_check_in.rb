#This module contains Interactors for processing check ins.
#  There are a lot of different 
module PreCheckIn
  class SMSCheck
    def initialize(check_in_message, email_of_store)
      message = ParseEmailMessage.new(check_in_message)
      store = Store.find_by_email(email_of_store)
      patron = Patron.find_by_digit_only_phone_number(message.local_part_only)

      case 
      when patron.nil
        enroller = EnrollPatron.start( phone_number: check_in_message.local_part_only )
        Rails.logger.info " #{self.class.to_s}##{__method__.to_s}: :enroll_patron #{parsed_message.sender} "
        PatronEnrollmentMailer.provide_name(parsed_message.sender).deliver_now
      
      when patron.pending
        #Finish sms_enrollment(patron: patron, full_name: message.body)
      else
        process_stamp(patron, store)
      end

    end
  end
end