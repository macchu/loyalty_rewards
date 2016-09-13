class AddStoreIdToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :store_id, :integer
  end
end
