class AddCompanyIdToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :company_id, :integer
  end
end
