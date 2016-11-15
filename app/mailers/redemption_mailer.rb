class RedemptionMailer < ApplicationMailer
  default from: "admin@rasmussonprogramming.com"

  def send_link(recipient, redemption_url)
    @redemption_url = redemption_url
    mail(to: recipient)

  end
end
