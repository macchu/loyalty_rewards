require 'test_helper'

class CheckInTest
  class FindStore < ActiveSupport::TestCase
    def setup
      @new_patron= patrons(:julieta)
      @coop = stores(:coop)
      @france_44 = stores(:france_44)
      @check_in = CheckIn.new(lat: @coop.lat, lng: @coop.lng, patron: @new_patron, store_id: nil)
    end

    test "Returns :ambiguous_stores for two close stores" do
      @check_in.find_store(10) #Ten ensures an ambiguous result.
      assert_equal :ambiguous_stores, @check_in.status
      assert_includes(@check_in.possible_stores, @coop)
      assert_includes(@check_in.possible_stores, @france_44)
    end

    test "Returns :success when one store matches" do
      @check_in.find_store()
      assert_equal :success, @check_in.status
      assert_nil @check_in.possible_stores
    end

    test "Returns :no_store found when there is not a matching store" do
      check_in_weird_location = CheckIn.create(lat: -50.50, lng: 50.50, patron: @new_patron, store_id: nil)
      check_in_weird_location.find_store()
      assert_equal :store_not_found, check_in_weird_location.status
      assert_nil @check_in.possible_stores
    end
    
  end
end