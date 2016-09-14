require 'test_helper'

class LoyaltyCardTerm < ActiveSupport::TestCase
  def setup
    @loyalty_card_term_for_coop = loyalty_card_terms(:loyalty_card_term_for_coop)
  end

  test 'ActiveRecord stuff' do
    assert_equal 1, LoyaltyCardTerm.count
  end

end