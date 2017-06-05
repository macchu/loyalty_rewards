class AdCampaignsController < ApplicationController
  layout 'store_admin'
  
  def new
    @store = Store.find(params[:store_id])
    @store.define_ad_campaign_targets
    @campaign = @store.ad_campaigns.build( { ad_campaign_targets_attributes: [ { patron_id: @store.patrons.first.id },
                                                                                {  patron_id: @store.patrons.last.id } ] })
    #@campaign.ad_campaign_targets = @store.potential_ad_campaign_targets
  end

  def create
    #byebug
    @campaign = AdCampaign.new(ad_campaign_params)
    @store = @campaign.store
    
    if @campaign.save
      flash[:success] = "Campaign updated."
      render :edit
    else
      flash[:error] = "Failed to create campaign."
      render :new
    end
  end

  def edit
    @store = Store.find(params[:store_id])
    @campaign = AdCampaign.find(:campaign_id)



  end

  def update

  end

  private
   def ad_campaign_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:ad_campaign).permit(:store_id, :platform_id, :description, ad_campaign_targets_attributes: [ :patron_id ])
    end

end