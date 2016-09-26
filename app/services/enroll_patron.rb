class EnrollPatron
  attr_reader :patron

  #Begin the enrollment process.
  def self.start(params)
    @patron = Patron.create(params)
    PatronEnrollmentMailer.provide_name(@patron.sms_address).deliver_now #TODO: move this inside EnrollPatron.
  end

  #Finish the enrollment process.
  def self.finish()

  end
end