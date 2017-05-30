class RemoveCompanyIdFromStores < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :company_id
  end
end
