require 'test_helper'

class LoyaltyCardTermTest < ActiveSupport::TestCase
  def setup
    @coop = stores(:coop)
    @loyalty_card_term_for_coop = loyalty_card_terms(:terms_for_coop)
  end

  test 'ActiveRecord stuff' do
    assert_equal 1, LoyaltyCardTerm.count
    assert_equal "Free mug", @loyalty_card_term_for_coop.reward_description
    assert_equal @coop, @loyalty_card_term_for_coop.store
  end

end