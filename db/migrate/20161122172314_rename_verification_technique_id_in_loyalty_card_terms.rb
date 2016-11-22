class RenameVerificationTechniqueIdInLoyaltyCardTerms < ActiveRecord::Migration[5.0]
  def change
    rename_column :loyalty_card_terms, :verification_technique_id, :check_in_strategy_id
  end
end
