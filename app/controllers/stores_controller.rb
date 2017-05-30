class StoresController < ApplicationController
  layout 'store_admin'
  before_action :set_layout_data
  
  def show
    @store = Store.find(params[:id])
    @patrons_count = @store.patrons.size
    @check_ins_count = @store.check_ins.size
    @redemptions_count = @store.redemptions.size
  end


  private

  def set_layout_data
    
  end

end