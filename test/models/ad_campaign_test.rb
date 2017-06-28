require 'test_helper'

class AdCampaignTest < ActiveSupport::TestCase
  def setup
    @facebook_for_france_44 = ad_campaigns(:facebook_for_france_44)

  end

  test "setup worked" do 
    @facebook_for_france_44
    assert @facebook_for_france_44
  end

  test ".with_patrons returns the correct AdCampaign" do
    assert_equal AdCampaign.with_patrons(ad_campaign_id: @facebook_for_france_44.id), @facebook_for_france_44
  end

  test ".with_patrons returns nil if the id is invalid" do
    assert_nil AdCampaign.with_patrons(ad_campaign_id: AdCampaign.last.id + 1)
  end

  test ".with_patrons includes AdCampaignTargets and Patrons" do
    campaign = AdCampaign.with_patrons(ad_campaign_id: @facebook_for_france_44.id)
    target = campaign.ad_campaign_targets.first
    assert_equal target.patron, Patron.find(target.patron_id)
  end

end