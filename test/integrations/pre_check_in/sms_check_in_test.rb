require 'test_helper'

class PreCheckInTest
  class SMSCheckInTest < ActionDispatch::IntegrationTest
    def setup
      new_patron_msg = Fixture('unknown_sender_with_code')
    end

    test 'A check in from a new patron generates an enrollment message.' do
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        @controller = CheckInMessageController.new(@message)
      end
      invite_email = ActionMailer::Base.deliveries.last
   
      assert_equal '6124567890@vzwpix.com', invite_email.to[0]
      assert_match(/Thanks!  Please reply to this message with your full name so we can "stamp" your card./, invite_email.body.to_s)
    
    end

    test 'A check from a new patron creates a pending patron.' do

    end

    test 'A pending patron retains the verification code from their purchase.' do

    end
  end
end