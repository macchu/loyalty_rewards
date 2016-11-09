require 'test_helper'
 
class RedemptionTest < ActionDispatch::IntegrationTest
  def setup
    #Hardcode a nearly full loyalty_card.
    @julieta = patrons(:julieta)
    @coop = stores(:coop)
    @card_for_julieta = @coop.create_loyalty_card_for_patron(@julieta)
    @card_for_julieta.stamp_count = @card_for_julieta.stamps_required - 1
    @card_for_julieta.save

    stamp_service = ApplyStampService.new(patron: @julieta, store: @coop, check_in: nil)
    @redemption_url = stamp_service.redemption_url
  end

  test "can see the welcome page." do
    get @redemption_url
    assert_match "Claim your #{@coop.loyalty_card_terms.last.reward_description}", response.body
    assert_select "form input" do
      assert_select "[value=?]", 'Claim'
    end
  end

  test "the Success page is rendered after claiming a reward." do
    patch "/redemption/", params: { redemption: { id: @card_for_julieta.redemption.id } }
    assert_match "Redeemed!", response.body
  end

  test "handle missing redemption" do
    get "/redemptions/redeem/-1"

    assert_match "Sorry, that redemption was not found.", response.body
  end
  
end