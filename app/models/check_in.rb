class CheckIn < ApplicationRecord
  acts_as_mappable

  attr_accessor :range
  attr_reader :status
  attr_reader :possible_stores  #Used for the ambiguous_stores scenario.



  accepts_nested_attributes_for :patronage_proof
  
  validates :phone_number, presence: { message: "must be given please" } 
  before_save :find_patron_and_store

  has_one :patronage_proof
  belongs_to :patron, optional: true
  belongs_to :store, optional: true
  belongs_to :check_in_strategy, optional: true

  def find_patron_and_store
    logger.info " #{self.class.to_s}##{__method__.to_s}"
    
    if patron.nil?
      find_patron
    else
      logger.info  "#{self.class.to_s}##{__method__.to_s}: skipping find_patron."
      @status = :success
    end

    if @status == :success && store_id.nil?
      find_store 
    else
      logger.info  "#{self.class.to_s}##{__method__.to_s}: skipping find_store."
    end

    if @status == :success
      stamp_card
    end

  end

  def find_patron
    logger.info " #{self.class.to_s}##{__method__.to_s}"

    patron_result = Patron.find_by_phone(self.phone_number)
    if patron_result.empty? #Patron not found
      logger.info " #{self.class.to_s}##{__method__.to_s}: Patron not found."
      @status = :enroll_patron
      self.patron_id = nil
    
    elsif patron_result.size > 1
      logger.info " #{self.class.to_s}##{__method__.to_s}: Duplicate patrons."
      @status = :duplicate_patrons

    else
      logger.info " #{self.class.to_s}##{__method__.to_s}: Found patron."
      @status = :success
      self.patron = patron_result.first
    end
  end

  def find_store(range=10.01)
    logger.info " #{self.class.to_s}##{__method__.to_s}"
    
    store_result = Store.within(range, origin: [self.lat, self.lng])
    if store_result.empty?
      logger.debug " #{self.class.to_s}##{__method__.to_s}: :store_not_found"
      @status = :store_not_found
      self.store_id = nil
    
    elsif store_result.size > 1
      logger.debug " #{self.class.to_s}##{__method__.to_s}: :ambiguous_stores"
      @status = :ambiguous_store
      @possible_stores = store_result
      self.store_id = nil

    else
      logger.debug " #{self.class.to_s}##{__method__.to_s}: :success"
      @status = :success
      self.store = store_result.first
    end
  end

  def stamp_card
    card = patron.find_or_create_loyalty_card(store.id)
    card.apply_stamp  #Wrap this in a service called ApplyStamp()?

  end

end
