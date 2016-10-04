class LoyaltyCardMailer < ActionMailer::Base
  default from: "desking.board@gmail.com"

  def stamped_card(recipient)
    loyalty_card_file = Rails.root.join('app', 'assets', 'images', 'lunchit_loyalty_card.jpg').to_s
    attachments['lunchit_loyalty_rewards.jpg'] = File.read(loyalty_card_file)
    mail(to: recipient, 
          subject: 'Thanks!',
          body: nil)

  end
end