class RemoveCompanyIdFromPatrons < ActiveRecord::Migration[5.0]
  def change
    remove_column :patrons, :company_id
  end
end
