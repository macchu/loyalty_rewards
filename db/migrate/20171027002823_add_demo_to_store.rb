class AddDemoToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :demo, :boolean
  end
end
