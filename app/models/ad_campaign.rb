class AdCampaign < ApplicationRecord
  belongs_to :store
  belongs_to :platform
  has_many :ad_campaign_targets, inverse_of: :ad_campaign
  accepts_nested_attributes_for :ad_campaign_targets

  def display_description
    if description.nil?
      platform.name
    else
      description
    end
  end

end