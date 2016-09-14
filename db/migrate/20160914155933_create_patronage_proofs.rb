class CreatePatronageProofs < ActiveRecord::Migration[5.0]
  def change
    create_table :patronage_proofs do |t|
      t.integer :check_in_id
      t.integer :patronage_verification_technique_id
      t.string :code
      t.string :receipt_location
      t.float :lat
      t.float :lng
    end
  end
end
