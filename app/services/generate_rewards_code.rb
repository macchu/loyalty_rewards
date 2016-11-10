class GenerateRewardsCode
  attr_reader :code
  attr_reader :qrcode_image
  
  def initialize(loyalty_card)
    case loyalty_card.redemption_code_type
    when :custom_formula

    when :qcode
      @code = random_alpha_numeric_string_generator
      qrcode = RQRCode::QRCode.new(@code)
      @qrcode_image = qrcode.as_png

    when :barcode

    when :random_alpha_numeric
      @code = random_alpha_numeric_string_generator
    else
      @code = random_alpha_numeric_string_generator
    end
  end

  def random_alpha_numeric_string_generator
    [*('a'..'z'),*('0'..'9')].shuffle[0,8].join
  end
end