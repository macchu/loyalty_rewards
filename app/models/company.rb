class Company < ApplicationRecord
  has_many :stores
  has_many :ad_campaigns
end
