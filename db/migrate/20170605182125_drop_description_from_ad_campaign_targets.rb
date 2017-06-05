class DropDescriptionFromAdCampaignTargets < ActiveRecord::Migration[5.0]
  def change
    remove_column :ad_campaign_targets, :description
  end
end
