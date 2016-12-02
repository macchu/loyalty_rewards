class PatronsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @patrons = @store.patrons
  end

  def show
    @store = Store.find(params[:store_id])
    @patron = Patron.find(params[:id])
    @check_ins_for_this_store = @patron.check_ins
  end

end