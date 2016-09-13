# Calculates how many punches the patron has achieved, chooses which loyalty card to display, and other information a patron
# would need to see after a successful check_in.  This service object also performs some decorator tasks for the view on
# behalf of the patron and store models.
class DisplayLoyaltyCard
  def initialize(patron, store)
    @patron = patron
    @store = store
  end

  def card_to_display()
    @store.loyalty_card_base_file_name + "_" + stamp_number()
  end

  def stamp_number
    2
  end 

    #This method should be moved into a presenter.
  def display_stamped_loyalty_card
    #How many checkins does the patron have at this store?
    check_in_count = @patron.count_check_ins

    #How many stamps are required?
    required_stamps = @store.required_stamps

    stamps_on_current_card = check_in_count % required_stamps

  end
end