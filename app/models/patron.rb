class Patron < ApplicationRecord
  require 'csv'

  scope :newer_patrons, -> { where("created_at > '#{30.days.ago}'") }
  scope :frequent_customers, -> { joins(:check_ins).group('patrons.id').having('count(check_ins) > 4')}
  scope :joins_check_ins, -> { joins(:check_ins).group('patrons.id') }
  scope :includes_check_ins, -> { includes(:check_ins).group('patrons.id') }
  
  has_many :check_ins
  has_many :loyalty_cards
  has_many :redemptions

  has_many :patron_stores
  has_many :stores, through: :patron_stores
   has_many :ad_campaign_targets, inverse_of: :patrons

  before_save :create_digit_only_phone_number

  #TODO: Delete if this is slower than .find_by_digit_only_phone_number().
  def self.find_by_phone(phone)
    digit_only_phone = phone.gsub(/\D/, '')
    self.where(digit_only_phone_number: digit_only_phone)
  end

  #TODO: Store in a database field or in a presenter.
  def full_name
    "#{first_name} #{last_name}"
  end

  def check_in_count
    self.check_ins.size
  end

  def stamp_count_for_store(store)
    card = current_loyalty_card_for_store(store)
    card.nil? ? 0 : card.stamp_count
  end

  def current_loyalty_card_for_store(store)
    card = LoyaltyCard.for_patron(self).for_store(store).most_recent(1)
    if card.empty?
      nil
    else
      card.first
    end
  end

  def display_current_loyalty_card_for_store(store)
    card = current_loyalty_card_for_store(store)
    if card.nil?
      ""
    else
      card.card_to_display
    end
  end

  def find_or_create_loyalty_card(store)
    loyalty_card = nil
    cards = self.loyalty_cards.where(store_id: store.id)
    
    if cards.empty?
      loyalty_card = store.create_loyalty_card_for_patron(self)
    else
      loyalty_card = cards.last
    end 

    #Is the card full?
    if loyalty_card.full?
      loyalty_card = store.create_loyalty_card_for_patron(self)
    end

    return loyalty_card
  end

  def finish_enrollment(_first_name, _last_name)
    self.first_name = _first_name
    self.last_name = _last_name
    self.pending = false
    self.save
  end

  private 
    def create_digit_only_phone_number()
      self.digit_only_phone_number = self.phone_number.gsub(/\D/, '')
    end
end
