class AddEmailForCheckInsToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :email_for_check_ins, :string
    add_index :stores, :email_for_check_ins
  end
end
