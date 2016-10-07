require 'test_helper'

class FindOrCreateLoyaltyCardTest < ActiveSupport::TestCase
  def setup
    @julieta = patrons(:julieta)
    @bill = patrons(:bill)

    @france_44 = stores(:france_44)
    @coop = stores(:coop)
    @settergrens = stores(:settergrens)

    @bills_coop_card = loyalty_cards(:card_for_bill)
    @bills_france44_card = loyalty_cards(:card_for_bill)
  end

  test 'creates a new card when patron had no cards at all' do
    assert_equal 0, @julieta.loyalty_cards.count
    card = @julieta.find_or_create_loyalty_card(@france_44)
    assert_equal 1, @julieta.loyalty_cards.size
    assert_equal @france_44, @julieta.loyalty_cards.first.store
  end

  test 'creates a new card when the patron had a card for a different store' do
    card = @bill.find_or_create_loyalty_card(@settergrens)
    assert_equal @settergrens, @bill.loyalty_cards.last.store
  end

  test 'finds a card for the appropriate store, when they have cards for multiple stores.' do
    assert_equal @bills_france44_card, @bill.find_or_create_loyalty_card(@france_44)
  end

  test 'creates a new card when the current card is full.' do
    #Fill the card.
    @bills_coop_card.stamp_count =  @bills_coop_card.stamps_required
    @bills_coop_card.save

    assert_difference("LoyaltyCard.count", +1) do
      @bill.find_or_create_loyalty_card(@france_44)
    end
  end
    
end
