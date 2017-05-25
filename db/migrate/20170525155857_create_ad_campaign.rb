class CreateAdCampaign < ActiveRecord::Migration[5.0]
  def change
    create_table :ad_campaigns do |t|
      t.integer :platform_id
      t.integer :company_id
    end
  end
end
