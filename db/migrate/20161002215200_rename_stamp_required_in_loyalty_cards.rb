class RenameStampRequiredInLoyaltyCards < ActiveRecord::Migration[5.0]
  def change
    change_table :loyalty_cards do |t|
      t.rename :stamp_required, :stamps_required
    end
  end
end
