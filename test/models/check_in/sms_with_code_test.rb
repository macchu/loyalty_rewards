require 'test_helper'

class SMSWithCodeTest < ActiveSupport::TestCase
  def setup
    @julieta = patrons(:julieta)
    @sms_with_code = check_in_strategies(:sms_with_code)
    CheckIn.create( check_in_strategy: CheckInStrategy.find_by_name(:sms_with_code), 
                    phone_number: @julieta.digit_only_phone_number)
  end

  test "Creates a CheckIn using the :sms_with_code strategy" do
    check_in = CheckIn.last
    assert_equal @sms_with_code, check_in.strategy
  end

end
