class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.float :lat
      t.float :lng
      t.string :phone_number

      t.timestamps
    end
  end
end
