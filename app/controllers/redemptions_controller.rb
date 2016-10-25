class RedemptionsController < ApplicationController

  def edit
    @redemption = Redemption.find_by_loyalty_card_id( params[:loyalty_card_id] )
    @loyalty_card = LoyaltyCard.find( params[:loyalty_card_id])
  end

  def update
    @redemption = Redemption.find(params[:redemption][:id])
    case @redemption.redeem
    when :success
      render :success
    when :already_redeemed
      render :already_redeemed
    else
      render :failed
    end
  end

  private
  
  # Rails 4+ requires parameter whitelisting.
  def redemptions_parameters
    params.require(:redemption).permit(:loyalty_card_id)
  end
end