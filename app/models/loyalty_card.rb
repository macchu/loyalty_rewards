class LoyaltyCard < ApplicationRecord
  belongs_to :patron
  belongs_to :store

  def card_to_display
    "#{store.name_with_underscores}_#{stamp_count}.jpg"
  end

  def apply_stamp

  end
end
