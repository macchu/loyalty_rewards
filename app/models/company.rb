class Company < ApplicationRecord
  has_many :stores
  has_many :ad_campaigns
  has_many :patrons
  has_many :check_ins

  def patron_count
    self.patrons.size
  end
end
