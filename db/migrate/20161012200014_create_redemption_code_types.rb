class CreateRedemptionCodeTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :redemption_code_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
