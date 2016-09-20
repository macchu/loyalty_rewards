require 'test_helper'

#Tests basic checkin and enrollment functionality.
class ParseEmailMessageTest < ActiveSupport::TestCase
  def setup
    # @julieta = patrons(:julieta)
    # @coop = stores(:coop)
    # @sms_with_code = check_in_strategies(:sms_with_code)
    # params =  { check_in_strategy: CheckInStrategy.find_by_name(:sms_with_code), 
    #             phone_number: @julieta.digit_only_phone_number,
    #             store: Store.find_by_email_for_check_ins('coop@stampstamp.com'),
    #             patronage_proof_attributes: { code: 'Z100'}
    #           }
    #@check_in = CheckIn.create( params )

    contents = File.open("#{fixture_path}sms_check_in_with_code.eml", "r"){ |file| file.read }
    message = Mail.new(contents)
    ap message
  end

  test 'Verify setup' do
    assert_equal 1, 1
  end

  # test 'Check In is created' do
  #   assert_equal 1, CheckIn.count
  # end

  # test "Code is stored in PatronageProofs." do
  #   assert_equal 1, PatronageProofs.count
  #   assert_equal "Z105", PatronageProofs.first.code
  # end

  # #TODO: A couple of different scenarios could result
  # #  from unknown email addresses: 
  # #   1. New patron 
  # #   2. Existing patron using a new email/sms.
  # test "Patron is identified from email address." do
  #   assert_equal @julieta, CheckIn.first.patron
  # end

  # test "The store is identified from email" do
  #   assert_equal @coop, CheckIn.first.store
  # end

end