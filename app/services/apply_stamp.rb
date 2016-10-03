class ApplyStamp
  attr_reader :card
  def initialize(patron:, store:, check_in:)
    #Create a check in if necessary.
    check_in ||= CheckIn.create(patron: patron, store: store)

    #Get or create the LoyaltyCard.
    @card = patron.find_or_create_loyalty_card(store)

    #Stamp the card.
    @card.apply_stamp

  end
end