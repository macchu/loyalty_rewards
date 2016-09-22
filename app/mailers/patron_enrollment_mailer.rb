class PatronEnrollmentMailer < ApplicationMailer
  default from: 'no-reply@example.com',
          return_path: 'system@example.com'

  def provide_name(patron_address)
    logger.info " #{self.class.to_s}##{__method__.to_s}: #{patron_address}"
    mail(to: patron_address,
  end
end
