class StoresController < ApplicationController
  layout 'store_admin'
  
  def show
    @store = Store.find(params[:id])
  end


  private

end