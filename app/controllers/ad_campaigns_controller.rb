class AdCampaignsController < ApplicationController
  layout 'store_admin'
  
  def new
    @store = Store.find(params[:store_id])
    @store.define_ad_campaign_targets
    @campaign = @store.ad_campaigns.build()
  end

  def create
    @campaign.ad_campaign_audience = @store.pending_ad_campaign_audience
    if @campaign.save
      flash[:notice] = "Campaign updated."
      redirect_to [@store, @campaign]
    else
      flash[:error] = "Failed to create campaign."
    end
  end

  def edit
    @store = Store.find(params[:store_id])
    @campaign = AdCampaign.find(:campaign_id)

  end

  def update

  end

  private

end