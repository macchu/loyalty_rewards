require 'test_helper'

class AdCampaignTest < ActiveSupport::TestCase
  def setup
    @facebook_for_coop = ad_campaigns(:facebook_for_coop)

  end

  test "setup worked" do 
    assert @facebook_for_coop
  end

end