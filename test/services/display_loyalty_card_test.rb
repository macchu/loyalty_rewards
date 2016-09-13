require 'test_helper'

class DisplayLoyaltyCardTest < ActiveSupport::TestCase
  def setup
    @patron = patrons(:bill)
    @store = stores(:france_44)
    @display_loyalty_card = DisplayLoyaltyCard.new(@patron, @store)
  end
  
  test 'Displays a card with two stamps' do 
    assert_equal "france_44_loyalty_card_stamps_2.jpg", @display_loyalty_card.card_to_display
  end

  test 'Displays a card with 10 stamps' do 
    assert_equal "france_44_loyalty_card_stamps_2.jpg", @display_loyalty_card.card_to_display
  end

  test 'Knows that a user has an unredeemed code' do
    assert_includes "234098", @display_loyalty_card.unredeemed_codes
  end

  test 'Knows when a user does NOT have an unredeemed code' do

  end

  test 'Knows how many stamps a card requires' do
    assert_equal 10, @display_loyalty_card.required_stamps
  end

  test "Has the customer's name" do
    assert_equal "Bill Johnson", @display_loyalty_card.patron_name
  end

  test "Provides a description of the reward." do
    assert_equal "Free beer opener.", @display_loyalty_card.patron_name
  end

  test "Provides the rewards expiration." do
    #assert_equal Date.new(2018, 1, 15), @display_loyalty_card.expriration
  end 
end