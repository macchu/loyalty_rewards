require 'test_helper'

class CheckInMessageControllerTest
  class PatronNameTest < ActionDispatch::IntegrationTest
    def setup
      @message = Mail.new(fixture('enrollment_message_with_patron_name'))
    end

    test 'Send message telling the patron we are finished.' do 
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        controller = CheckInMessageController.new(@message)
      end
      invite_email = ActionMailer::Base.deliveries.last
   
      assert_equal '6124567890@vzwpix.com', invite_email.to[0]
      assert_match(/Thanks!  Please reply to this message with your full name so we can "stamp" your card./, invite_email.body.to_s)
    end

    test 'Patron should be created and they should have one stamp.' do
      assert_difference 'Patron.count', +1 do
        controller = CheckInMessageController.new(@message)
      end

      assert_equal "John Crichton", Patron.last.full_name
      #assert_match /John Crichton/, @message.body_text_part
    end

  end
end