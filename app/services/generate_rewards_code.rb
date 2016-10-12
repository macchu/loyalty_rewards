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
      random_alpha_
    end
  end

  def random_number_generator

  end
end