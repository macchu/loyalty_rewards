require 'test_helper'

class RedemptionMailerTest < ActionMailer::TestCase
  test 'Email gets sent' do
     # Create the email and store it for further assertions
    email = RedemptionMailer.send_link('me@example.com',
                                           'http://www.example.com/redemptions/redeem/1234')
 
    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end
 
    # Test the body of the sent email contains what we expect it to
    #assert_equal '', email.subject
    assert_includes 'Click this link when you are ready to redeem your reward: http://www.example.com/redemptions/redeem/1234.', email.body.to_s.strip
    
  end

end
