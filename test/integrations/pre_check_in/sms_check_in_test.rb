require 'test_helper'

class PreCheckInTest
  class SMSCheckInTest < ActionDispatch::IntegrationTest
    def setup
      @actionmailer_size_start = ActionMailer::Base.deliveries.size
      @new_patron_msg = Mail.new(fixture('unknown_sender_with_code'))
      PreCheckIn::SMSCheckIn.new(@new_patron_msg,'france_44@stampstamp.com')
    end

    test 'A check in from a new patron generates an enrollment message.' do
      assert 1, ActionMailer::Base.deliveries.size - @actionmailer_size_start 
      
      invite_email = ActionMailer::Base.deliveries.last
      assert_equal '6124567890@vzwpix.com', invite_email.to[0]
      assert_match /Thanks!  Please reply to this message with your full name so we can "stamp" your card./, 
                    invite_email.body.to_s
    end

    test 'The new patron is marked as pending.' do
      assert Patron.last.pending
    end

    test 'A pending patron retains the verification code from their purchase.' do
      assert 'Z105', Patron.last.check_ins.last.patronage_proof.code
    end

    test 'Patron.sms_address was set.' do
      assert '6124567890@vzwpix.com', Patron.last.sms_address
    end
  end

  class FinishEnrollmentTest < ActionDispatch::IntegrationTest
    def setup
      @walter = patrons(:walter)
      @actionmailer_size_start = ActionMailer::Base.deliveries.size
      @new_patrons_name_msg = Mail.new(fixture('enrollment_message_with_patron_name'))
      PreCheckIn::SMSCheckIn.new(@new_patrons_name_msg,'france_44@stampstamp.com')
    end

    test 'The patron is no longer pending' do
      assert @walter.pending

      refute Patron.last.pending
      assert_equal @walter, Patron.last
    end

    test 'A thank you email was sent.' do

    end

    test 'A stamped card was attached to the message.' do

    end


  end
end