class CreateCheckInStrategies < ActiveRecord::Migration[5.0]
  def change
    create_table :check_in_strategies do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :check_in_strategies, :name
  end
end
