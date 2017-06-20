class AdCampaignsController < ApplicationController
  layout 'store_admin'
  
  def index
    @store = Store.find(params[:store_id])
  end

  def filter

  end

  def new
    @store = Store.find(params[:store_id])
    @store.define_ad_campaign_targets

    potential_ad_campaign_targets = filter_ad_campaign_targets(params[:filter])
    @campaign = @store.ad_campaigns.build( { ad_campaign_targets_attributes: potential_ad_campaign_targets })
    #@campaign = @store.ad_campaigns.build( { ad_campaign_targets_attributes: [ { patron_id: @store.patrons.first.id },
     #                                                                           {  patron_id: @store.patrons.last.id } ] })
    #@campaign.ad_campaign_targets = @store.potential_ad_campaign_targets
  end

  def create
    @campaign = AdCampaign.new(ad_campaign_params)
    @store = @campaign.store
    
    if @campaign.save
      flash.now[:success] = "Campaign created."
      redirect_to store_ad_campaign_path(@store, @campaign)
    else
      flash.now[:error] = "Failed to create campaign."
      render :new
    end
  end

  def show
    @store = Store.find(params[:store_id])
    @campaign = @store.ad_campaigns.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = "Could not find that ad campaign."
      
  end

  def edit
    @store = Store.find(params[:store_id])
    @campaign = AdCampaign.find(params[:id])
  end

  def update
    @store = Store.find(params[:store_id])
    @campaign = AdCampaign.find(params[:id])

    if @campaign.update(ad_campaign_params)
      flash.now[:success] = "Campaign updated."
      render :edit
    else
      flash.now[:error] = "Failed to update campaign."
      render :new
    end
  end

  def destroy
    @store = Store.find(params[:store_id])
    @campaign = @store.ad_campaigns.find(params[:id])

    if @campaign.destroy
      flash.now[:success] = "Campaign deleted."
      redirect_to store_ad_campaigns_path(@store)
    else
      flash.now[:error] = "Campaign could not be deleted."
      redirect_to store_ad_campaigns_path(@store)
    end
  end

  private
   def ad_campaign_params
      # It's mandatory to specify the nested attributes that should be whitelisted.
      # If you use `permit` with just the key that points to the nested attributes hash,
      # it will return an empty hash.
      params.require(:ad_campaign).permit(:store_id, :platform_id, :description, ad_campaign_targets_attributes: [ :patron_id ])
    end

    def filter_ad_campaign_targets(filter)
      case filter
      when "newer_customers"
        @store.patrons.newer_patrons.map { |p| { patron_id: p.id } }
      when "its_been_awhile"
        @store.its_been_awhile.map { |p| { patron_id: p.id } }
      else
        @store.patrons.map { |p| { patron_id: p.id } }
      end
    end

end