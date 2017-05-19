class AddIsDemoToRedemption < ActiveRecord::Migration[5.0]
  def change
    add_column :redemptions, :is_demo, :boolean
  end
end
