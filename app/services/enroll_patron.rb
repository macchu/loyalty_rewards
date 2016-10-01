class EnrollPatron
  attr_reader :patron

  #Begin the enrollment process.
  def self.start(params)
    patron = Patron.create(params)
    PatronEnrollmentMailer.provide_name(patron.sms_address).deliver_now
    return patron
  end

  #Finish the enrollment process.
  def self.finish(patron_to_finish:, enrollment_message: )
    name_parser = FullNameParser.new(enrollment_message.body_text_part)

    patron_to_finish.finish_enrollment(name_parser.first_name, name_parser.last_name)

    PatronEnrollmentMailer.received_name(patron_to_finish).deliver_now
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