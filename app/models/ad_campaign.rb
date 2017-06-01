class AdCampaign < ApplicationRecord
  belongs_to :store
  belongs_to :platform
  has_many :ad_campaign_targets

end