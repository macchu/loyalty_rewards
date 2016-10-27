require 'test_helper'

class RedemptionsControllerShowTest < ActionDispatch::IntegrationTest
  def setup
  end

  test 'Renders error when the Redemption does not exist.' do 
    ap Rails.application.routes.named_routes.helper_names
    assert Redemption.count < 100  #Ensure the fixtures setup some redemptions.
    unknown_id = 101  #Pick an ID that likely does not exist.

    get redemption_url, params: { id: unknown_id }
    assert_response :success
  end
end