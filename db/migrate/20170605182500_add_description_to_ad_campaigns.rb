class AddDescriptionToAdCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_column :ad_campaigns, :description, :string
  end
end
