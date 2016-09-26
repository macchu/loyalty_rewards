class AddFullSmsAddressToPatrons < ActiveRecord::Migration[5.0]
  def change
    add_column :patrons, :sms_address, :string
  end
end
