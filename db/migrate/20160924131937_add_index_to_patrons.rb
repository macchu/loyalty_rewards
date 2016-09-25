class AddIndexToPatrons < ActiveRecord::Migration[5.0]
  def change
    add_index :patrons, :digit_only_phone_number
  end
end
