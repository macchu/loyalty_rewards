class RedemptionsController < ApplicationController

  def edit
    @redemption = Redemption.find_by_loyalty_card_id( params[:loyalty_card_id] )
  end

  private
  
  # Rails 4+ requires parameter whitelisting.
  def redemptions_parameters
    params.require(:redemption).permit(:loyalty_card_id)
  end
end