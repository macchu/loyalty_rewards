class Redemption < ApplicationRecord
  belongs_to :store
  belongs_to :patron
  belongs_to :loyalty_card
end
