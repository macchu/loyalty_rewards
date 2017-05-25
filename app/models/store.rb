class Store < ApplicationRecord
  acts_as_mappable

  has_many :check_ins
  has_many :loyalty_cards
  has_many :loyalty_card_terms
  has_many :redemptions
  belongs_to :redemption_code_type

  has_many :patron_stores
  has_many :patrons, through: :patron_stores

  def self.find_store_for_check_in(range, coordinates)
    result = Store.within(range, origin: coordinates) 
  end

  def create_loyalty_card_for_patron(patron)
    logger.info " #{self.class.to_s}##{__method__.to_s}: for store #{self.id} and patron #{patron.id}".blue
    
    terms = self.loyalty_card_terms.last
    logger.info " #{self.class.to_s}##{__method__.to_s}: #{terms.inspect}  logger.info ".blue

    card = self.loyalty_cards.build( patron: patron, 
                                    stamps_required: terms.stamps_required,
                                    stamp_count: 0,
                                    date_issued: Time.zone.now )
    card.save
    return card
  end

  # Replaces "France 44" with "France_44".
  # Useful for finding loyalty card file names.
  # TODO: Make this a database field or move logic into a presenter.
  def name_with_underscores
    name.gsub(" ", "_")
  end

  def check_ins_count
    self.check_ins.all.size
  end

  def redemptions_count
    self.redemptions.all.size
  end


end
