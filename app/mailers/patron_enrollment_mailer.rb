class PatronEnrollmentMailer < ApplicationMailer
  default from: "admin@rasmussonprogramming.com",
          return_path: "admin@rasmussonprogramming.com"

  def provide_name(patron_address)
    logger.info " #{self.class.to_s}##{__method__.to_s}: #{patron_address}"
    mail(to: patron_address)
  end

  def received_name(patron)
    logger.info " #{self.class.to_s}##{__method__.to_s}: #{patron.full_name}"
    #TODO: Use a model and/or a service to determine the stamped card's location and what card to display.
    # loyalty_card_file = Rails.root.join('app', 'assets', 'images', 'lunchit_loyalty_card.jpg').to_s
    # attachments['loyalty_card.jpg'] = File.read(loyalty_card_file)
    mail(to: patron.sms_address, subject: "Thanks, #{patron.first_name}!", body: nil)

  end
end
