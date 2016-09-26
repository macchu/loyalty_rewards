class EnrollPatron
  attr_reader :patron

  #Begin the enrollment process.
  def self.start(params)
    @patron = Patron.create(params)
  end

  #Finish the enrollment process.
  def self.finish()

  end
end