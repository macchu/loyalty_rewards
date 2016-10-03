class ApplyStamp
  attr_reader :card
  def initialize(patron:, store:, check_in:)
    Rails.logger.info " #{self.class.to_s}##{__method__.to_s}"
    #Create a check in if necessary.
    check_in ||= CheckIn.create(patron: patron, store: store)

    #Get or create the LoyaltyCard.
    @card = store.create_loyalty_card_for_patron(patron)

    #Stamp the card.
    @card.apply_stamp
  end
end