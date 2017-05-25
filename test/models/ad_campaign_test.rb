require 'test_helper'

class AdCampaignTest < ActiveSupport::TestCase
  def setup
    @facebook_for_france_44 = ad_campaigns(:facebook_for_france_44)

  end

  test "setup worked" do 
    assert_equal "France 44", @facebook_for_france_44.company.name
    assert_equal "Facebook", @facebook_for_france_44.platform.name
  end

end