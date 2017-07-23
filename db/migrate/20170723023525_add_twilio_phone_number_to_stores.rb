class AddTwilioPhoneNumberToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :twilio_phone_number, :string
    add_index :stores, :twilio_phone_number
  end
end
