class EnrollPatron
  #Begin the enrollment process.
  def self.start(phone_number)
    if Patron.create(phone_number: phone_number, pending: true)

    else
      #TODO: Send error email.
    end
  end

  #Finish the enrollment process.
  def self.finish()

  end
end