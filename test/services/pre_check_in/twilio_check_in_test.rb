require 'test_helper'

#Tests basic checkin and enrollment functionality.
class TwilioCheckInTests 
  class TwilioCheckInTestsForNewPatrons < ActiveSupport::TestCase
    def setup
      #Twilio receives SMS messages, parses the envelope, and then sends the info to us vai HTTP Post parameters.
      #   The following are parameters for different scenarios.
      @to_phone = "+19526496372"
      @new_patron_phone = "+16121239999"
      @new_patron_message = "Code: 1234"
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
                                  "From"=>@new_patron_phone, 
                                  "ApiVersion"=>"2010-04-01"}
      @twilio_check_in_service = PreCheckIn::TwilioCheckIn.new( @new_patron_request )
    end

    test "verify setup" do
      assert_equal @new_patron_phone, @new_patron_request["From"]
      assert_equal @to_phone, @new_patron_request["To"]
    end

    test 'new patron is marked as pending.' do
      p = Patron.find_by_digit_only_phone_number("16121239999")
      assert p.pending
    end
    
    test "the new patron is checked in at the store." do
      p = Patron.find_by_digit_only_phone_number("16121239999")
      s = Store.find_by_twilio_phone_number("19526496372")
      
      check_in = CheckIn.last

      assert_equal p, check_in.patron
      assert_equal s, check_in.store
    end

    test "the pending patron is asked for their name." do
      assert_equal "Hi. To enroll you I need your first and last name.",
                     @twilio_check_in_service.response_content
    end

    test "when 'To' does not match a business, an error is raised." do

    end
  end

  class TwilioCheckInTestsForNewDemoPatrons < ActiveSupport::TestCase
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

      @twilio_check_in_service = PreCheckIn::TwilioCheckIn.new( @new_patron_request )
    end

    test "Created a patron named 'Demo User' that is not pending" do
      p = Patron.last
      assert_match "Demo User", p.full_name
      refute p.pending
    end

    test "A card is sent" do
      # Relevant mailer test is found in 'test/mailers/patron_enrollment_mailer_test.rb'
    end

  end

  class TwilioCheckInTestsForExistingPatrons < ActiveSupport::TestCase
    def setup
      #Twilio receives SMS messages, parses the envelope, and then sends the info to us vai HTTP Post parameters.
      #   The following are parameters for different scenarios.
      @to_phone = "+19526496372"
      @existing_patron = patrons(:julieta)
      @existing_patron_phone = @existing_patron.digit_only_phone_number
      @existing_patron_message = "Code: 1234"
      @existing_patron_request = { "ToCountry"=>"US", 
                                  "ToState"=>"MN", 
                                  "SmsMessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "NumMedia"=>"0", "ToCity"=>"MINNEAPOLIS", 
                                  "FromZip"=>"55439", 
                                  "SmsSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "FromState"=>"MN", 
                                  "SmsStatus"=>"received", 
                                  "FromCity"=>"MINNEAPOLIS", 
                                  "Body"=>@existing_patron_message, 
                                  "FromCountry"=>"US", 
                                  "To"=> @to_phone, 
                                  "ToZip"=>"55402", 
                                  "NumSegments"=>"1", 
                                  "MessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "AccountSid"=>"AC50bf348fe4af16648f0221c88ed60c3c", 
                                  "From"=>@existing_patron_phone, 
                                  "ApiVersion"=>"2010-04-01"}

      
    end

    test "verify setup" do
      assert @existing_patron_phone, '7015551234'
    end

    test "a new punch is applied" do
      assert_difference '@existing_patron.check_ins.size' do
        PreCheckIn::TwilioCheckIn.new( @existing_patron_request )
        @existing_patron.reload
      end
    end

    test "the proof of purchase code is stored" do
      PreCheckIn::TwilioCheckIn.new(@existing_patron_request)
      assert_equal "Code: 1234", CheckIn.last.patronage_proof.code
    end

    test "response text says 'Got it!'" do
      twilio_check_in_service = PreCheckIn::TwilioCheckIn.new(@existing_patron_request)
      assert_match "Got it!", twilio_check_in_service.response_content
    end
  end
end