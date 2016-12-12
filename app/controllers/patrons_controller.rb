class PatronsController < ApplicationController
  layout 'store_admin'

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
    @check_ins_for_this_store = @patron.check_ins.for_store(@store).limit(10)
    ap @store
    @current_card = @patron.display_current_loyalty_card_for_store(@store)
  end

end