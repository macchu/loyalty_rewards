require 'test_helper'

class ApplyStampTest < ActiveSupport::TestCase
  def setup
    @full_card = loyalty_cards(:full_card)
  end

  test 'Verify setup' do
    assert_equal 10, @full_card.stamp_count
  end

  test 'A new loyalty card is created and stamped if the current card is full.' do
    
  end
end
