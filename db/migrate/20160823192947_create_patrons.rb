class CreatePatrons < ActiveRecord::Migration[5.0]
  def change
    create_table :patrons do |t|
      t.string :phone_number
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
