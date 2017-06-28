class AdCampaign < ApplicationRecord
  require 'csv'

  belongs_to :store
  belongs_to :platform
  has_many :ad_campaign_targets, inverse_of: :ad_campaign
  has_many :patrons, through: :ad_campaign_targets
  accepts_nested_attributes_for :ad_campaign_targets

  def display_description
    if description.nil?
      platform.name
    else
      description
    end
  end

  def self.with_targets(ad_campaign_id:)
    AdCampaign.where(id: ad_campaign_id).includes(ad_campaign_targets: [:patron]).first
  end

  #MDR: Seems to be slower than campaign.patrons.each do |p| !
  #   May need to try this with larger data set.  Only used 37 so far.
  def self.with_patrons(ad_campaign_id:)
     AdCampaign.where(id: ad_campaign_id).includes(:patrons).first
  end

end