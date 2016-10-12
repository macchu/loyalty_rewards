require 'test_helper'

class RedemptionCodeTypeTest < ActiveSupport::TestCase
  def setup
    @france_44 = stores(:france_44)
    @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
    @full_card = loyalty_cards(:full_card)
  end

  test 'Returns nil when redemption_code_type is nil.' do
    assert_equal nil, @loyalty_card_for_bill.redemption_code_type
  end

  test 'Returns :qcode.' do

  end
end
