require 'test_helper'

class PatronageVerificationTechniqueTest < ActiveSupport::TestCase
  def setup
    @technique = patronage_verification_techniques(:check_in)
  end

  test "ActiveRecord stuff" do 
    assert_equal 1, PatronageVerificationTechnique.count
  end
end