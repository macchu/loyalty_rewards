require 'test_helper'

class RedemptionsControllerShowTest < ActionDispatch::IntegrationTest
  def setup
    @redeemed = redemptions(:redeemed)
    @unredeemed = redemptions(:unredeemed)
  end

  test 'Handles a Redemption does not exist.' do 
    #assert Redemption.count < 100  #Ensure the fixtures setup some redemptions.
    Redemption.delete_all
    unknown_id = 101

    get redemption_url, params: { id: unknown_id }
    assert_response :success
  end

  test 'Handles a redemption that is redeemed.' do
    get redemption_url, params: { id: @redeemed.id }
    assert_response :success
  end

  test 'Hanldes a redemption that is unredeemed.' do
    get redemption_url, params: { id: @unredeemed.id }
    assert_response :redirect
  end

end