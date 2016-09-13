class AddDigitOnlyPhoneNumberToPatron < ActiveRecord::Migration[5.0]
  def change
    add_column :patrons, :digit_only_phone_number, :integer
  end
end
