class CreateStamps < ActiveRecord::Migration[5.0]
  def change
    create_table :stamps do |t|
      t.integer :loyalty_card_id
      t.datetime :date_given
      t.integer :patron_id
      t.integer :store_id

      t.timestamps
    end
  end
end
