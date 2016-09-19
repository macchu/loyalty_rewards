class AddCheckInStrategyIdToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :check_in_strategy_id, :integer
  end
end
