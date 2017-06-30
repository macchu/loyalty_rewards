class PatronsController < ApplicationController
  layout 'store_admin'
  before_action :set_current_tile

  def index
    @store = Store.find(params[:store_id])
    @patrons = @store.patrons
    
    respond_to do |format|
      format.html
      format.csv
    end
  end

  def show
    @store = Store.find(params[:store_id])
    @patrons = @store.patrons
    @patron = Patron.find(params[:id])
    @check_ins = @patron.check_ins.for_store(@store).order(created_at: :desc).limit(10)
    @current_card = @patron.display_current_loyalty_card_for_store(@store)
  end

  private 

  # Helps toggle the store admin title buttons
  #  so they have a "clicked" appearance.
  def set_current_tile
    @clicked_tile = "patrons"
  end

end