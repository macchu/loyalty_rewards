class AdCampaignsController < ApplicationController
  layout 'store_admin'
  
  def new
    @store = Store.find(params[:store_id])
    @campaign = @store.ad_campaigns.build()
  end

  def create
    
  end

  private

end