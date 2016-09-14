class PatronageProof < ApplicationRecord
  belongs_to :check_in
  belongs_to :patronage_verification_technique
end