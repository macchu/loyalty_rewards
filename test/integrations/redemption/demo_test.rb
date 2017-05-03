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

  test "has a special view for demo redemptions" do
    get "/redemptions/demo/1"

    assert_match "Thanks for trying the demo."
  end
  
end