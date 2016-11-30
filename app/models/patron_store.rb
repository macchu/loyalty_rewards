class PatronStore < ApplicationRecord
  belongs_to :patron
  belongs_to :store
end