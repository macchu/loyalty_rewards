class GenerateRewardsCode
  attr_reader :code
  
  def initialize(loyalty_card)
    store = loyalty_card.store
    
    case loyalty_card.redemption_type
    when :custom_formula

    when :qcode

    when :barcode

    when :alpha_numeric

    else
      @code = random_alpha_numeric
    end
  end

  def random_alpha_numericnumber_generator
    [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
  end
end