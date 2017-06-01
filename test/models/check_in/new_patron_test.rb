require 'test_helper'

class CheckInTest
  class NewPatronScenarios < ActiveSupport::TestCase
    def setup
      @unknown_phone = '6124567890'
      @coop = stores(:coop)
      params =  { phone_number: @unknown_phone ,
                  store: @coop,
                  patronage_proof_attributes: { code: 'Z100'}
                }
      @check_in = CheckIn.create( params )
    end

    test 'Ensure 6124567890 is not a known patron.' do
      assert_nil Patron.find_by_digit_only_phone_number(@unknown_phone)
    end

    test "Creates a check in, but knows Patron needs to finish enrolling." do
      assert_equal @coop, @check_in.store
      assert_equal 'Z100', @check_in.patronage_proof.code
    end

  end
end
