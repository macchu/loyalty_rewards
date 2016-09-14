class CreateLoyaltyCardTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :loyalty_card_terms do |t|
      t.integer :store_id
      t.string :reward_description
      t.integer :stamp_count
      t.date :expiration
      t.integer :verification_technique_id
    end
  end
end
