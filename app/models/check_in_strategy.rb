class CheckInStrategy < ApplicationRecord
  has_many :check_ins
  has_many :loyalty_card_terms
end
