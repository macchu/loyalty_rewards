require 'test_helper'

class SMSWithCodeTest < ActiveSupport::TestCase
  def setup
    @julieta = patrons(:julieta)
    @coop = stores(:coop)
    @sms_with_code = check_in_strategies(:sms_with_code)
    params =  { check_in_strategy: CheckInStrategy.find_by_name(:sms_with_code), 
                phone_number: @julieta.digit_only_phone_number,
                store: Store.find_by_email_for_check_ins('coop@stampstamp.com'),
                patronage_proof_attributes: { code: 'Z100'}
              }
    @check_in = CheckIn.create( params )
  end

  test "Creates a CheckIn using the :sms_with_code strategy" do
    assert_equal @sms_with_code, @check_in.check_in_strategy
    assert_equal @coop, @check_in.store
    assert_equal 'Z100', @check_in.patronage_proof.code
    assert_equal :success, @check_in.status
  end

end
