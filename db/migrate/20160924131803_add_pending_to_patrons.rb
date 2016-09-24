class AddPendingToPatrons < ActiveRecord::Migration[5.0]
  def change
    add_column :patrons, :pending, :boolean
  end
end
