class AddPatronIdToCheckIns < ActiveRecord::Migration[5.0]
  def change
    add_column :check_ins, :patron_id, :integer
  end
end
