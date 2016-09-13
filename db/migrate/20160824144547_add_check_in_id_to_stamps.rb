class AddCheckInIdToStamps < ActiveRecord::Migration[5.0]
  def change
    add_column :stamps, :check_in_id, :integer
  end
end
