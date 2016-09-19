require 'test_helper'

#Tests basic checkin and enrollment functionality.
class ReceiveEmailServiceTest < ActiveSupport::TestCase
  def setup
    @patron = patrons(:bill)
    @store = stores(:france_44)

    system "cat #{Rails.root}/test/fixtures/sms_check_in_with_code.eml | ruby -r #{Rails.root}/app/services/receive_email_service.rb -e ReceiveEmailService.start"

  end

  # test 'sandbox' do
  #   system "cat #{Rails.root}/test/fixtures/check_in.eml | ruby -r #{Rails.root}/app/services/receive_email_service.rb -e ReceiveEmailService.start"

  # end

  test 'Check In is created' do
    #system "cat #{Rails.root}/test/fixtures/check_in.eml | ruby -r #{Rails.root}/app/services/receive_email_service.rb -e ReceiveEmailService.start"
    assert_equal 1, CheckIn.count
  end

  test "Code is stored in PatronageProofs." do
    assert_equal 1, PatronageProofs.count
    assert_equal "Z105", PatronageProofs.first.code
  end

  #TODO: A couple of different scenarios could result
  #  from unknown email addresses: 
  #   1. New patron 
  #   2. Existing patron using a new email/sms.
  test "Patron is identified from email address." do
    assert_equal @julieta, CheckIn.first.patron
  end

  test "The store is identified from email" do
    assert_equal @coop, CheckIn.first.store
  end

end