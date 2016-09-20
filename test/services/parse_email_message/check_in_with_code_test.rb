require 'test_helper'

#Tests basic checkin and enrollment functionality.
class ParseEmailMessageTest < ActiveSupport::TestCase
  def setup
    
  end

  test 'Check In is created' do
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