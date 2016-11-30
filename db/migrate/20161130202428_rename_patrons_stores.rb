class RenamePatronsStores < ActiveRecord::Migration[5.0]
  def change
    rename_table :patrons_stores, :patron_stores
  end
end
