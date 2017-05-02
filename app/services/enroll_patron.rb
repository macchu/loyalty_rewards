class EnrollPatron
  attr_reader :patron

  #Create a pending patron and send message asking patron for their name.
  def self.start(params)
    patron = Patron.create(params)
    PatronEnrollmentMailer.provide_name(patron.sms_address).deliver_now
    return patron
  end

  #Marks the patron as enrolled.
  def self.finish(patron_to_finish:, enrollment_message: )
    name_parser = FullNameParser.new(enrollment_message.body_text_part)

    patron_to_finish.finish_enrollment(name_parser.first_name, name_parser.last_name)
  end

end

class FullNameParser
  attr_reader :first_name, :last_name
  
  def initialize(full_name)
    full_name_array = full_name.split(" ")
    @first_name = full_name_array.first
    @last_name = full_name_array.last
  end 
end