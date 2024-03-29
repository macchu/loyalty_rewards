class Redemption < ApplicationRecord
  belongs_to :store
  belongs_to :patron
  belongs_to :loyalty_card
  belongs_to :redemption_code_type

  def redeem
    if redeemed #Prevents people from faking redemptions by bypassing the controller/view logic.
      return :already_redeemed
    elsif self.update_attributes( {redeemed: true, code: GenerateRewardsCode.new(loyalty_card).code} )
      return :success
    else
      return :failed
    end
  end

  def code_as_image
    case self.redemption_code_type.description
    when "qrcode"
      qrcode = RQRCode::QRCode.new(self.code)
      qrcode.as_html

    when "barcode"
      nil
    else
      nil
    end
  end

end
