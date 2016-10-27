require 'test_helper'

class LoyaltyCardTest < ActiveSupport::TestCase
  def setup
    #@bill = patrons[:bill]
    @france_44 = stores(:france_44)
    @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
    @full_card = loyalty_cards(:full_card)
  end

  test 'fixture configuration' do
    assert_equal "Bill", @loyalty_card_for_bill.patron.first_name
    assert_equal "France 44", @loyalty_card_for_bill.store.name
  end

  test 'Displays a card with two stamps' do 
    assert_equal "France_44_2.jpg", @loyalty_card_for_bill.card_to_display
  end

  test 'Knows how many stamps a card requires' do
    assert_equal 10, @loyalty_card_for_bill.stamps_required
  end

  test "Has the customer's name" do
    assert_equal "Bill Johnson", @loyalty_card_for_bill.patron.full_name
  end

  test "Provides a description of the reward." do
    assert_equal "Free mug", @loyalty_card_for_bill.reward_description
  end

  test "Provides the rewards expiration." do
    #assert_equal Date.new(2018, 1, 15), @display_loyalty_card.expriration
  end 

  test '.full?' do
    assert @full_card.full?
  end

  test '.create_redemption_if_full creates a redemption when it is full.' do
    Redemption.delete_all

    assert_difference("Redemption.count", +1) do
      @full_card.create_redemption_if_full
    end
    refute Redemption.last.redeemed
  end

  test '.create_redemption_if_full does NOT create additional redemptions when one already exists.' do
    Redemption.delete_all
    @full_card.create_redemption_if_full
    assert_equal Redemption.last, @full_card.redemption

    assert_difference("Redemption.count", 0) do
      @full_card.create_redemption_if_full
    end
    assert_equal Redemption.last, @full_card.redemption
  end

  test '.create_redemption_if_full does NOT create a redemption when the card is not full.' do
    assert_difference("Redemption.count", 0) do
      @loyalty_card_for_bill.create_redemption_if_full
    end
    assert_equal nil, @loyalty_card_for_bill.redemption
  end

end
