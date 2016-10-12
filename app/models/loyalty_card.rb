class LoyaltyCard < ApplicationRecord
  belongs_to :patron
  belongs_to :store 

  def card_to_display
    "#{store.name_with_underscores}_#{stamp_count}.jpg"
  end

  def apply_stamp
    self.stamp_count ||= 0 #Set stamp_count to 0 if it was nil.
    self.stamp_count += 1
    self.save
  end

  def full?
    self.stamp_count.nil? ? false : self.stamps_required <= self.stamp_count
  end

  def redemption_code_type
    store.redemption_code_type
  end
end
