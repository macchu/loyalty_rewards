require 'test_helper'

class StoreTest 
  class CreateLoyaltyCardForPatronTest < ActiveSupport::TestCase
    def setup
      @coop = stores(:coop)
      @france_44 = stores(:france_44)

    end

    test ".create_loyalty_card_for_patron" do
      assert_difference("LoyaltyCard.count", + 1) do
        @coop.create_loyalty_card_for_patron(@bill)
      end
    end
  end
end