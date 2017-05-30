class RemoveCompanyIdFromCheckIns < ActiveRecord::Migration[5.0]
  def change
    remove_column :check_ins, :company_id
  end
end
