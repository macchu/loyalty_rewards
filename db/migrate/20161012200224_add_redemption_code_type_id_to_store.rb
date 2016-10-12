class AddRedemptionCodeTypeIdToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :redemption_code_type_id, :integer
  end
end
