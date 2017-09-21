class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def messaging
    logger.info " #{self.class.to_s}##{__method__.to_s}: received message."
    
    ngrok_url = "http://d604bee4.ngrok.io"
    twilio_message_processor = PreCheckIn::TwilioCheckIn.new(params)

    #image = "https://www.plasticresource.com/dynamic-media/products/images/loyalty/26154-Back.png?gravity=northwest&v=image420x350&k=80%2FN4%2B8JNrl87LJN5X%2FAfA"
    
    # response = Twilio::TwiML::MessagingResponse.new do |r|
    #   ap twilio_message_processor.response_content
    #   ap twilio_message_processor.file_name_of_card
    #   r.message(body: twilio_message_processor.response_content, media_url: image)
    #   #r.message.media_url = image  #Undefined method.
    #   #Didn't work.
    #   #r.media(media: image)  #Crashed because method doesn't exist.  #Undefined  method 'media'
    #   #r.message(media: image) #Schema validation error
    # end

    response = Twilio::TwiML::MessagingResponse.new
    response.message do |message|
      message.body(twilio_message_processor.response_content)
      
      if !twilio_message_processor.file_name_of_card.nil?
        image = ActionController::Base.helpers.asset_path(twilio_message_processor.file_name_of_card)
        #image_url = "#{ngrok_url}#{image}"  #For development environment.
        image_url = "http://www.freebeefor.me#{image}"
        message.media(image_url)
      end
    end
    # response = Twilio::TwiML::MessagingResponse.new
    # response.message do |message|
    #   message.body('Store Location: 123 Easy St.')
    #   message.media('https://demo.twilio.com/owl.png')
    # end

    #render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Message MediaUrl0=\"http://0ac188fd.ngrok.io/assets/satisfaction-icon-d17cc3c4760c9e2b6ec8bdf355512eed7679cba01b0fd3a485ec0e2fb255d961.png\">hey there <Media>#{image}</Media></Message></Response>"
    render :xml => response.to_s
  end
end