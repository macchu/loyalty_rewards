class RedemptionMailer < ApplicationMailer
  default from: "demo@freebeefor.me"

  def send_link(recipient, redemption_url)
    @redemption_url = redemption_url
    mail(to: recipient)

  end
end
