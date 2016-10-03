require 'test_helper'

class ApplyStampTest < ActiveSupport::TestCase
  def setup
    #Fill the card with stamps.
    @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
    @loyalty_card_for_bill.stamp_count = @loyalty_card_for_bill.stamps_required
    @loyalty_card_for_bill.save

    @bill = @loyalty_card_for_bill.patron
    @store = @loyalty_card_for_bill.store

  end

  test 'Verify setup' do
    assert_equal 10, @loyalty_card_for_bill.stamp_count
  end

  test 'A new loyalty card is created and stamped if the current card is full.' do
    assert_difference("LoyaltyCard.count", +1) do
      ApplyStamp.new(patron: @bill, store: @store, check_in: nil)
    end
  end
end
