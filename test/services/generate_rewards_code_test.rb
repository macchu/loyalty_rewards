require 'test_helper'

class GenerateRewardsCodeTest < ActiveSupport::TestCase
  def setup
    @loyalty_card_for_bill = loyalty_cards(:card_for_bill)
  end

  test 'A random alpha numeric string is generated for France 44, since no code was specified.' do 
    code = GenerateRewardsCode.new(@loyalty_card_for_bill).code
    assert code.length > 0
    assert_equal String, code.class
  end

  test 'A random alpha numeric string is generated when a card is specified.' do 
    # Define a redemption code type.
    card = loyalty_cards(:new_card_for_bill)
    card.store.redemption_code_type = redemption_code_types(:random_alpha_numeric)
    card.store.save

    # Run the test.
    code = GenerateRewardsCode.new(card).code
    assert code.length > 0
    assert_equal String, code.class
  end
end