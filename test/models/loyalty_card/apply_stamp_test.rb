require 'test_helper'

class ApplyStampTest < ActiveSupport::TestCase
  def setup
    @bill = patrons(:bill)
    @coop = stores(:coop)
    @loyalty_card_for_bill = loyalty_cards(:new_card_for_bill)
  end

  test "Verify setup" do
    assert_equal 0, @loyalty_card_for_bill.stamp_count
  end

  test ".stamp_count is incremented when first stamp is applied" do 
    @loyalty_card_for_bill.apply_stamp
    assert_equal 1, LoyaltyCard.find(@loyalty_card_for_bill.id).stamp_count
  end
end
