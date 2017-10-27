require 'test_helper'

class TwilioControllerTest < ActionDispatch::IntegrationTest
  def setup
      #Twilio receives SMS messages, parses the envelope, and then sends the info to us vai HTTP Post parameters.
      #   The following are parameters for different scenarios.
      @to_phone = '+16125554444'
      @new_patron_message = "Hello?"
      @new_patron_request = { "ToCountry"=>"US", 
                                  "ToState"=>"MN", 
                                  "SmsMessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "NumMedia"=>"0", "ToCity"=>"MINNEAPOLIS", 
                                  "FromZip"=>"55439", 
                                  "SmsSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "FromState"=>"MN", 
                                  "SmsStatus"=>"received", 
                                  "FromCity"=>"MINNEAPOLIS", 
                                  "Body"=>@new_patron_message, 
                                  "FromCountry"=>"US", 
                                  "To"=> @to_phone, 
                                  "ToZip"=>"55402", 
                                  "NumSegments"=>"1", 
                                  "MessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "AccountSid"=>"AC50bf348fe4af16648f0221c88ed60c3c", 
                                  "From"=>'6121239876@vzwpix.com', 
                                  "ApiVersion"=>"2010-04-01"}

    end

  test "should receive Twilio XML" do
    post twilio_messaging_url, @new_patron_request
    #ap response.body
    assert_response :success
    assert_select "Body", "Thanks! Send one more text to see an award code."
    assert_select "Media", /http:\/\/www\.freebeefor\.me\/assets.*jpg/
  end
end