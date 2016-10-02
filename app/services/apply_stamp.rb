class ApplyStamp
  def initialize(patron:, store:, check_in=nil)
    #Create a check in if necessary.
    check_in ||= CheckIn.create(patron: patron, store: store)


    #Get or create the LoyaltyCard.
    loyalty_card = patron.find_or_create_loyalty_card(store)


    #Stamp the card.
    loyalty_card.apply_stamp

    #Send the loyalty card. 
  end
end