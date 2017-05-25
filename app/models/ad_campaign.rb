class AdCampaign < ApplicationRecord
  belongs_to :company
  belongs_to :platform

end