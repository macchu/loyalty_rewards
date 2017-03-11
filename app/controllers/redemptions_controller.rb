class RedemptionsController < ApplicationController
  layout 'customers'

  def show
    @redemption = Redemption.find(params[:id])

    if @redemption.nil?
      render :not_found
    elsif @redemption.redeemed
      render :already_redeemed
    else
      redirect_to "/redemptions/redeem/#{@redemption.id}"
    end

    rescue ActiveRecord::RecordNotFound
      render :not_found
  end

  def edit
    @redemption = Redemption.find( params[:redemption_id] )

  rescue ActiveRecord::RecordNotFound
    render :not_found
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