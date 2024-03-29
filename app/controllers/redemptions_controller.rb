class RedemptionsController < ApplicationController
  layout 'hero_page'
  before_action :set_current_tile
  
  def index
    if params[:store_id]
      index_for_store_admin
    else
      index_for_patrons
    end
  end

  def index_for_store_admin
    @store = Store.find(params[:store_id])
    render :index, layout: 'store_admin'
  end

  def index_for_patrons
    
  end

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

  def finish_demo
    #@redemption = Redemption.find(params[:id])
    render :finished_demo

  end

  private
  
  # Rails 4+ requires parameter whitelisting.
  def redemptions_parameters
    params.require(:redemption).permit(:loyalty_card_id)
  end

  # Helps toggle the store admin title buttons
  #  so they have a "clicked" appearance.
  def set_current_tile
    @clicked_tile = "redemptions"
  end
end