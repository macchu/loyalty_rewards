require 'test_helper'

class CheckInMessageControllerTest
  class EnrollmentTest < ActionDispatch::IntegrationTest
    def setup
      @message = Mail.new(fixture('unknown_sender_with_code'))
    end

    test 'Send an invitation message when receiving unknown check_in.' do 
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        @controller = CheckInMessageController.new(@message)
      end
      invite_email = ActionMailer::Base.deliveries.last
   
      assert_equal '6124567890@vzwpix.com', invite_email.to[0]
      assert_match(/What is your name?  First & Last please./, invite_email.body.to_s)
    end

  end
end