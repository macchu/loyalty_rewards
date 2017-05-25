class AdCampaign < ApplicationRecord
  belongs_to :company
  has_one :platform

end