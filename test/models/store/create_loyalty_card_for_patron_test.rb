require 'test_helper'

class StoreTest 
  class CreateLoyaltyCardForPatronTest < ActiveSupport::TestCase
    def setup
      @julieta = patrons(:julieta)
      @coop = stores(:coop)
    end

    test ".create_loyalty_card_for_patron creates a new loyalty card." do
      assert_difference("LoyaltyCard.count", + 1) do
        @coop.create_loyalty_card_for_patron(@julieta)
      end
    end

    test "The new card has the proper stamp_count, stamps_required, etc." do
      card = @coop.create_loyalty_card_for_patron(@julieta)
      assert_equal 9, card.stamps_required
      assert_equal 0, card.stamp_count
      assert_equal @julieta, card.patron
      assert_equal @coop, card.store
    end
  end
end