require 'test_helper'

class ApplyStampServiceTest < ActiveSupport::TestCase
  def setup
    #Fill the card with stamps.
    @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
    @loyalty_card_for_bill.stamp_count = @loyalty_card_for_bill.stamps_required
    @loyalty_card_for_bill.save

    @bill = @loyalty_card_for_bill.patron
    @store = @loyalty_card_for_bill.store

    @nearly_full_card = loyalty_cards(:nearly_full_card)
    @patron_for_nearly_full = @nearly_full_card.patron
    @store_for_nearly_full = @nearly_full_card.store
  end

  test 'Verify setup' do
    assert_equal 10, @loyalty_card_for_bill.stamp_count
  end

  test 'A new loyalty card is created and stamped if the current card is full.' do
    assert_difference("LoyaltyCard.count", +1) do
      ApplyStampService.new(patron: @bill, store: @store, check_in: nil)
    end
  end

  test 'A Redemption is created when the card is full' do
    assert_difference("Redemption.count", +1) do
      ApplyStampService.new(patron: @patron_for_nearly_full, store: @store_for_nearly_full, check_in: nil)
    end
  end

  test '.file_name_of_card' do
    stamp_service = ApplyStampService.new(patron: @patron_for_nearly_full, store: @store_for_nearly_full, check_in: nil)
    assert_equal "France_44_10.jpg", stamp_service.file_name_of_card
  end

  test '.redemption_url' do
    stamp_service = ApplyStampService.new(patron: @patron_for_nearly_full, store: @store_for_nearly_full, check_in: nil)
    assert_equal "http://www.stampstamp.com/redemptions/redeem/#{@nearly_full_card.redemption.id}", stamp_service.redemption_url
  end

  test 'full_card' do

  end
end
