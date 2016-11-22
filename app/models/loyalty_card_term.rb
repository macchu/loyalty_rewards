class LoyaltyCardTerm < ApplicationRecord
  belongs_to :store
  belongs_to :check_in_strategy

end