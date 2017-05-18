class LoyaltyCard < ApplicationRecord
  belongs_to :patron
  belongs_to :store 
  has_one :redemption

  scope :for_store, -> (store_id) { where("store_id = ?", store_id) }
  scope :for_patron, -> (patron_id) { where("patron_id =?", patron_id) }
  scope :most_recent, -> (limit) { order("created_at desc").limit(limit) }

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

  def create_redemption_if_full(is_demo: false)
    logger.info " #{self.class.to_s}##{__method__.to_s}: full? #{self.full?} redemption.nil? #{self.redemption.nil?}"
    if self.full? and self.redemption.nil?
      redemption = Redemption.new(loyalty_card: self, store: self.store, patron: self.patron, redemption_code_type: self.store.redemption_code_type)
      redemption.redeemed = false
      redemption.save
    end
  end

  def redemption_code_type
    case 
    when store.nil?
      nil
    when store.redemption_code_type.nil?
      nil
    else
      store.redemption_code_type.description.downcase.to_sym
    end
  end

  def reward_description
    case 
    when store.nil?
      nil
    when store.loyalty_card_terms.empty?
      nil
    else
      store.loyalty_card_terms.first.reward_description
    end
  end
end
