require 'test_helper'
 
class DemoRedemptionTest < ActionDispatch::IntegrationTest
  def setup
    #Hardcode a nearly full loyalty_card.
    @julieta = patrons(:julieta)
    @coop = stores(:coop)
    @card_for_julieta = @coop.create_loyalty_card_for_patron(@julieta)
    @card_for_julieta.stamp_count = @card_for_julieta.stamps_required - 1
    @card_for_julieta.save

    stamp_service = ApplyStampService.new(patron: @julieta, store: @coop, check_in: nil, is_demo: true)
    @redemption_url = stamp_service.redemption_url
  end


  test "a successful demo redemption page displays additional marketing information" do
    patch "/redemption/", params: { redemption: { id: @card_for_julieta.redemption.id } }
    
    assert_match "Cool, right?", response.body
  end
end