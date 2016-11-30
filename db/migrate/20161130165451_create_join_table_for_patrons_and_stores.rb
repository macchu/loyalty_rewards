class CreateJoinTableForPatronsAndStores < ActiveRecord::Migration[5.0]
  def change
    create_join_table :stores, :patrons
  end
end
