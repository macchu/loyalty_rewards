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

    test 'An email was sent after finishing enrollment.' do
      assert_equal 1, ActionMailer::Base.deliveries.size - @actionmailer_size_start 
    end

    test 'A stamped card was attached to the message.' do
      message = ActionMailer::Base.deliveries.last
      assert 'loyalty_card.jpg', message.attachments.first.filename
    end
  end

  class NormalCheckInTest < ActionDispatch::IntegrationTest
    def setup
      @existing_patron_message = Mail.new(fixture('sms_check_in_with_code'))
      @julieta = patrons(:julieta)
      @coop = stores(:coop)
      @card_for_julieta = @coop.create_loyalty_card_for_patron(@julieta)
      @actionmailer_size_start = ActionMailer::Base.deliveries.size
      #PreCheckIn::SMSCheckIn.new(@existing_patron_message,'linden_hills_coop@stampstamp.com')
    end

    test 'Julieta has a new stamp on her existing coop card.' do
      assert_equal 0, @card_for_julieta.stamp_count
      PreCheckIn::SMSCheckIn.new(@existing_patron_message,'linden_hills_coop@stampstamp.com')
      assert_equal 1, @julieta.loyalty_cards.count
      assert_equal 1, LoyaltyCard.find(@card_for_julieta.id).stamp_count
    end

    test 'A stamped card was attached to the message.' do
      PreCheckIn::SMSCheckIn.new(@existing_patron_message,'linden_hills_coop@stampstamp.com')
      message = ActionMailer::Base.deliveries.last
      assert 'loyalty_card_1.jpg', message.attachments.first.filename
    end

    test 'A card with two stamps is sent during the second check in.' do
      #Hardcode an extra stamp on the loyalty_card.
      @card_for_julieta.stamp_count = 2
      @card_for_julieta.save

      PreCheckIn::SMSCheckIn.new(@existing_patron_message,'linden_hills_coop@stampstamp.com')
      message = ActionMailer::Base.deliveries.last
      assert 'loyalty_card_2.jpg', message.attachments.first.filename
    end

    test 'Julieta gets a new card & stamp for her first time checking into a new store.' do

    end

    test 'When julieta fills a card, she gets sent a benefit code & a new card.' do

    end
  end
end