module PreCheckIn
  class SMSCheck
    def initialize(check_in_message, email_of_store)
      patron = Patron.find_by_phone(check_in_message.local_part_only)
    end
  end
end