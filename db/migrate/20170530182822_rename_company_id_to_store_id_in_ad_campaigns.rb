class RenameCompanyIdToStoreIdInAdCampaigns < ActiveRecord::Migration[5.0]
  def change
    rename_column :ad_campaigns, :company_id, :store_id
  end
end
