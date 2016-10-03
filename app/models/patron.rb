class Patron < ApplicationRecord
  has_many :check_ins
  has_many :loyalty_cards

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

  def find_or_create_loyalty_card(store_id)
    cards = self.loyalty_cards.where(store_id: store_id)

    loyalty_card = cards.empty? ? self.loyalty_cards.create(store_id: store_id) : cards.last

    #Is the card full?
    if loyalty_card.full?
      self.loyalty_cards.create(store_id: store_id)
    end
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
