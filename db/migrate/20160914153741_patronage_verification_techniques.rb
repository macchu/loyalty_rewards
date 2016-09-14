class PatronageVerificationTechniques < ActiveRecord::Migration[5.0]
  def change
    create_table :patronage_verification_techniques do |t|
      t.integer :store_id
      t.string :description
    end
  end
end
