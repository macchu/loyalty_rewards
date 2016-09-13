class CreateLoyaltyCards < ActiveRecord::Migration[5.0]
  def change
    create_table :loyalty_cards do |t|
      t.integer :patron_id
      t.integer :store_id
      t.datetime :date_issued
      t.datetime :date_completed
      t.integer :stamp_required
      t.integer :stamp_count

      t.timestamps
    end
  end
end
