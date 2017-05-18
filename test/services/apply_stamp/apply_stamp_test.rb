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

    @new_card = loyalty_cards(:new_card_for_bill)
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
    assert_match "/redemptions/redeem/#{@nearly_full_card.redemption.id}", stamp_service.redemption_url
  end

  test ".redemption_url contains '/redeem/demo/' when redeeming a demo card" do
    stamp_service = ApplyStampService.new(patron: @patron_for_nearly_full, store: @store_for_nearly_full, check_in: nil, is_demo: true)
    assert_match "/redemptions/redeem/demo/#{@nearly_full_card.redemption.id}", stamp_service.redemption_url
  end

  test '.full_card is true for a full card' do
    stamp_service = ApplyStampService.new(patron: @patron_for_nearly_full, store: @store_for_nearly_full, check_in: nil)
    assert stamp_service.full_card
  end

  test '.full_card is false for an empty card' do
    stamp_service = ApplyStampService.new(patron: @new_card.patron, store: @new_card.store, check_in: nil)
    refute stamp_service.full_card
  end

  test 'CheckIn.resulting_stamp_count is saved in the associated CheckIn' do
    check_in = CheckIn.create(patron: @new_card.patron, store: @new_card.store, phone_number: "5551231234" )
    stamp_service = ApplyStampService.new(patron: @new_card.patron, store: @new_card.store, check_in: check_in)

    #Reload the objects.
    check_in = CheckIn.find(check_in.id)
    new_card = LoyaltyCard.find(@new_card.id)

    assert_equal check_in.resulting_stamp_count, new_card.stamp_count
  end

  test 'CheckIn.resulting_stamp_count == 1 when a new card is started after filling a card.' do
    check_in = CheckIn.create(patron: @bill, store: @store, phone_number: @bill.phone_number )
    ApplyStampService.new(patron: @bill, store: @store, check_in: check_in)

    assert_equal 1, check_in.resulting_stamp_count
  end
end
