require 'test_helper'

class PatronTest
  class FindOrCreateLoyaltyCardTest < ActiveSupport::TestCase
    def setup
      @julieta = patrons(:julieta)
      @bill = patrons(:bill)
      @france_44 = stores(:france_44)
      @coop = stores(:coop)
      @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
    end

    test 'creates a new card when patron had no cards at all' do
      assert_equal 0, @julieta.loyalty_cards.count
      card = @julieta.find_or_create_loyalty_card(@france_44.id)
      assert_equal 1, @julieta.loyalty_cards.size
      assert_equal @france_44, @julieta.loyalty_cards.first.store

    end

    test 'creates a new card when the patron had a card for a different store' do
      assert_equal 1, @bill.loyalty_cards.size
      card = @bill.find_or_create_loyalty_card(@coop.id)
      assert_equal 2, @bill.loyalty_cards.size
      assert_equal @coop, @bill.loyalty_cards.last.store
    end

    test 'finds a patrons existing card without creating a new one.' do
      assert_equal @france_44, @bill.find_or_create_loyalty_card(@france_44.id)
    end

    test 'creates a new card when the current card is full.' do
      #Fill the card.
      @loyalty_card_for_bill.stamp_count =  @loyalty_card_for_bill.stamps_required
      @loyalty_card_for_bill.save

      assert_difference("LoyaltyCard.count", +1) do
        @bill.find_or_create_loyalty_card(@france_44.id)
      end
    end
      
  end
end