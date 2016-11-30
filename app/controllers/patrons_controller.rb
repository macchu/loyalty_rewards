class PatronsController < ApplicationController
  def index
    @store = Store.find(params[:store_id])
    @patrons = @store.patrons
  end

  def show

  end

end