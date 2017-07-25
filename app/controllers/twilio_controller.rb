class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def messaging
    logger.info " #{self.class.to_s}##{__method__.to_s}: received message."
    
    # PreCheckIn::SMSCheckIn.new(message,'france_44@stampstamp.com')
    # to = params["To"]
    # from = params["From"]
    # body = params["Body"]

    response = Twilio::TwiML::MessagingResponse.new do |r|
      #r.message(to: '6125816321', from: '19526496372', body: "Got it!")
      r.message(body: "Got it!")
    end

    render :xml => response.to_s
  end
end