class AdCampaignTarget < ApplicationRecord
  attr_accessor :description, :patron

  belongs_to :ad_campaign
  #validates_presence_of :ad_campaign
  has_one :patron
end
