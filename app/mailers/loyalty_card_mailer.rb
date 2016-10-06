class LoyaltyCardMailer < ActionMailer::Base
  default from: "desking.board@gmail.com"

  def stamped_card(recipient, stamped_card)
    loyalty_card_file = Rails.root.join('app', 'assets', 'images', stamped_card).to_s
    attachments[stamped_card] = File.read(loyalty_card_file)
    mail(to: recipient, 
          subject: 'Thanks!',
          body: nil)

  end
end