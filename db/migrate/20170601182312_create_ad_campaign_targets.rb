class CreateAdCampaignTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_campaign_targets do |t|
      t.string :description
      t.integer :ad_campaign_id
      t.integer :patron_id

      t.timestamps
    end
  end
end
