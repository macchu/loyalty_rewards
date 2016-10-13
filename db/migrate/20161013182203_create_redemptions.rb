class CreateRedemptions < ActiveRecord::Migration[5.0]
  def change
    create_table :redemptions do |t|
      t.integer :loyalty_card_id
      t.integer :redemption_code_type_id
      t.string :code
      t.integer :store_id
      t.integer :patron_id
      t.boolean :redeemed

      t.timestamps
    end
  end
end
