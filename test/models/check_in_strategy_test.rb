require 'test_helper'

class CheckInStrategyTest < ActiveSupport::TestCase
  def setup
    @sms_with_code = check_in_strategies(:sms_with_code)
  end
  
  test 'CheckInStrategy model & migrations work.' do
    refute_empty CheckInStrategy.all
  end

  test "A CheckInStrategy can be found by name." do
    assert_equal @sms_with_code, CheckInStrategy.find_by_name(:sms_with_code)
  end
end
