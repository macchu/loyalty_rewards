class ChangeDigitOnlyPhoneNumberToString < ActiveRecord::Migration[5.0]
  def change
    change_column :patrons, :digit_only_phone_number, :string
  end
end
