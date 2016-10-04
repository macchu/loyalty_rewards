require 'test_helper'

class PreCheckInTest
  class EnrollmentTest < ActionDispatch::IntegrationTest
    def setup
      @actionmailer_size_start = ActionMailer::Base.deliveries.size
      @new_patron_msg = Mail.new(fixture('unknown_sender_with_code'))
      PreCheckIn::SMSCheckIn.new(@new_patron_msg,'france_44@stampstamp.com')
    end

    test 'A check in from a new patron generates an enrollment message.' do
      assert_equal 1, ActionMailer::Base.deliveries.size - @actionmailer_size_start 
      
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
      @pending_patron = patrons(:pending_patron)
      @new_patrons_name_msg = Mail.new(fixture('enrollment_message_with_patron_name'))
      @actionmailer_size_start = ActionMailer::Base.deliveries.size
      PreCheckIn::SMSCheckIn.new(@new_patrons_name_msg,'france_44@stampstamp.com')
    end

    test 'The patron is no longer pending' do
      assert @pending_patron.pending

      refute Patron.find(@pending_patron.id).pending
    end

    test 'A thank you email was sent.' do
      ap "mailer start size: #{@actionmailer_size_start} mailer_end_size: #{ActionMailer::Base.deliveries.size}"
      assert_equal 1, ActionMailer::Base.deliveries.size - @actionmailer_size_start 
    end

    test 'A stamped card was attached to the message.' do
      message = ActionMailer::Base.deliveries.last
      assert 'loyalty_card.jpg', message.attachments.first.filename
    end
  end

end