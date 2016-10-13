require 'test_helper'

class RedemptionCodeTypeTest < ActiveSupport::TestCase
  def setup
    @card_without_redemption_type = loyalty_cards(:card_for_bill)
    @card_with_redemption_type = loyalty_cards(:new_card_for_bill)
  end

  test 'Returns nil when redemption_code_type is nil.' do
    assert_equal nil, @card_without_redemption_type.redemption_code_type
  end

  test 'Returns :qcode.' do
    assert_equal :qcode, @card_with_redemption_type.redemption_code_type 
  end
end
