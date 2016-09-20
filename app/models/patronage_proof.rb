class PatronageProof < ApplicationRecord
  #To get nested_attributes to pass through CheckIn.create
  #  'optional: true' was necessary.
  belongs_to :check_in, optional: true  
  belongs_to :patronage_verification_technique, optional: true
end