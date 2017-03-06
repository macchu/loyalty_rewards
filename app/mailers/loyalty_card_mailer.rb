class LoyaltyCardMailer < ActionMailer::Base
  default from: "demo@freebeefor.me"
  
  def stamped_card(recipient, stamped_card)
    loyalty_card_file = Rails.root.join('app', 'assets', 'images', stamped_card).to_s
    Rails.logger.debug "Attachment: #{loyalty_card_file}".blue
    attachments[stamped_card] = File.read(loyalty_card_file)
    mail( to: recipient, 
          subject: 'Thanks!',
          body: nil)
  end
end