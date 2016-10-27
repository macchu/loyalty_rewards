class RedemptionMailer < ApplicationMailer
  default from: "desking.board@gmail.com"

  def send_link(recipient, redemption_url)
    @redemption_url = redemption_url
    mail(to: recipient)

  end
end
