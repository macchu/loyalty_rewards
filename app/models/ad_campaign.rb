class AdCampaign < ApplicationRecord
  require 'csv'

  belongs_to :store
  belongs_to :platform
  has_many :ad_campaign_targets, inverse_of: :ad_campaign
  accepts_nested_attributes_for :ad_campaign_targets

  #scope :targets, -> { includes(:ad_campaign_targets).group('ad_campaign.id') }
  scope :with_patrons, -> { includes(:patron).group('ad_campaign_target.id').group('ad_campaign_target.id') } 

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

end