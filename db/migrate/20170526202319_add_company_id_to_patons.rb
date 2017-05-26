class AddCompanyIdToPatons < ActiveRecord::Migration[5.0]
  def change
    add_column :patrons, :company_id, :integer
  end
end
