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
      PreCheckIn::TwilioCheckIn.new( @new_patron_request )
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

    test "when 'To' does not match a business, an error is raised." do

    end
  end
  class TwilioCheckInTestsForPendingPatrons < ActiveSupport::TestCase
    def setup
      #Twilio receives SMS messages, parses the envelope, and then sends the info to us vai HTTP Post parameters.
      #   The following are parameters for different scenarios.
      @to_phone = "+19526496372"
      @pending_patron = patrons(:pending_patron)
      @pending_patron_phone = @pending_patron.digit_only_phone_number
      @pending_patron_message = "Jonas Vivian"
      @pending_patron_request = { "ToCountry"=>"US", 
                                  "ToState"=>"MN", 
                                  "SmsMessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "NumMedia"=>"0", "ToCity"=>"MINNEAPOLIS", 
                                  "FromZip"=>"55439", 
                                  "SmsSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "FromState"=>"MN", 
                                  "SmsStatus"=>"received", 
                                  "FromCity"=>"MINNEAPOLIS", 
                                  "Body"=>@pending_patron_message, 
                                  "FromCountry"=>"US", 
                                  "To"=> @to_phone, 
                                  "ToZip"=>"55402", 
                                  "NumSegments"=>"1", 
                                  "MessageSid"=>"SM1c37d0428333837af4942e8f26e4fd85", 
                                  "AccountSid"=>"AC50bf348fe4af16648f0221c88ed60c3c", 
                                  "From"=>@pending_patron_phone, 
                                  "ApiVersion"=>"2010-04-01"}

      PreCheckIn::TwilioCheckIn.new( @pending_patron_request )
    end

    test "verify setup" do
      assert @pending_patron_phone, '7015551234'
    end

    test "the patron is no longer pending" do
      @pending_patron.reload 
      refute @pending_patron.pending #Reload the patron.
    end

    test "the patron's name is received and stored in the database" do
      assert_equal 
    end
  end
end