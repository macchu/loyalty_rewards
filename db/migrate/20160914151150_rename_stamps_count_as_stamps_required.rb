class RenameStampsCountAsStampsRequired < ActiveRecord::Migration[5.0]
  def change    
    change_table :loyalty_card_terms do |t|
      t.rename :stamp_count, :stamps_required
    end
  end
end
