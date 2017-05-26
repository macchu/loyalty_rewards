class AddCompanyIdToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :company_id, :integer
  end
end
