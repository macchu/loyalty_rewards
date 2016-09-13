require 'test_helper'

class CheckInTest
  class Create < ActiveSupport::TestCase
    def setup
      @julieta = patrons(:julieta)
      @coop = stores(:coop)
    end

    test "missing phone returns validation error" do
      check_in = CheckIn.create(phone_number: nil, lat: 44.921919, lng: -93.328703 )
      assert_equal check_in.valid?, false
    end

    test "CheckIn with a known phone number returns :success." do
      check_in = CheckIn.create(phone_number: '(952) 876-1234', lat: 44.921919, lng: -93.328703 )
      assert_equal check_in.patron, @julieta
      assert_equal @coop, check_in.store
      assert_equal :success, check_in.status

    end

    test "CheckIn with an unknown phone number returns :enroll_patron." do
      check_in = CheckIn.create(phone_number: '(100) 100-1234', lat: 44.921919, lng: -93.328703 )
      assert_equal check_in.phone_number, '(100) 100-1234'
      assert_equal :enroll_patron, check_in.status
    end
  end
end