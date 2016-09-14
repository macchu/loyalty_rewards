require 'test_helper'

class PatronageProofTest < ActiveSupport::TestCase
  def setup
    @check_in = patronage_proofs(:check_in)
  end

  test "ActiveRecord stuff" do 
    assert_equal 1, PatronageProof.count
  end
end