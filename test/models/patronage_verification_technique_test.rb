require 'test_helper'

class PatronageVerificationTechniqueTest < ActiveSupport::TestCase
  def setup
    @technique = patronage_verification_techniques(:check_in)
  end

  test "ActiveRecord stuff" do 
    assert PatronageVerificationTechnique.count > 0
  end
end