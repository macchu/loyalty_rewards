require 'test_helper'

class LoyaltyCardTerm < ActiveSupport::TestCase
  def setup
    @loyalty_card_term_for_coop = loyalty_card_terms(:loyalty_card_terms_for_coop)
  end

  test 'ActiveRecord stuff' do
    assert_equal "Free mug", @loyalty_card_term_for_coop.reward_description
  end

end