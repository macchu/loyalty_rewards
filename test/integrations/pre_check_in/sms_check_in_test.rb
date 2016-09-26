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
      assert_match /Thanks!  Please reply to this message with your full name so we can "stamp" your card./, invite_email.body.to_s
    
    end

    test 'A check from a new patron creates a pending patron.' do
      assert Patron.last.pending
    end

    test 'A pending patron retains the verification code from their purchase.' do
      ap Patron.last.check_ins
      ap PatronageProof.last
      assert 'Z105', Patron.last.check_ins.last.patronage_proof.last
    end
  end
end