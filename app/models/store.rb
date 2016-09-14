class Store < ApplicationRecord
  acts_as_mappable

  has_many :check_ins
  has_many :loyalty_cards
  has_many :loyalty_card_terms

  def self.find_store_for_check_in(range, coordinates)
    result = Store.within(range, origin: coordinates) 
  end

  # Replaces "France 44" with "France_44".
  # Useful for finding loyalty card file names.
  # TODO: Make this a database field or move logic into a presenter.
  def name_with_underscores
    name.gsub(" ", "_")
  end
end
