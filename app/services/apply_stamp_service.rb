class ApplyStampService
  attr_reader :file_name_of_card
  attr_reader :redemption_url
  #TODO: card = ApplyStampService.new() looks bad.  What syntax more
  # clearly communicates that we are stamping a card and returning that card for
  # to be sent?
  def initialize(patron:, store:, check_in:)
    Rails.logger.info " #{self.class.to_s}##{__method__.to_s}"
    #Create a check in if necessary.
    check_in ||= CheckIn.create(patron: patron, store: store)

    #Get or create the LoyaltyCard.
    card = patron.find_or_create_loyalty_card(store)
    
    #Stamp the card.
    card.apply_stamp

    #Create redemption if card is full
    if card.full?
      card.create_redemption_if_full
      @redemption_url = "http://www.stampstamp.com/redemptions/redeem/#{card.redemption.id}"
    end

    @file_name_of_card = card.card_to_display
  end

end