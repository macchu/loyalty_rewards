class AdCampaignTarget < ApplicationRecord
  belongs_to :ad_campaign
  #validates_presence_of :ad_campaign
  belongs_to :patron


end
