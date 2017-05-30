require 'test_helper'

class AdCampaignTest < ActiveSupport::TestCase
  def setup
    @facebook_for_france_44 = ad_campaigns(:facebook_for_france_44)

  end

  test "setup worked" do 
    ap @facebook_for_france_44
  end

end