require 'test_helper'

class CheckInTest
  class Update < ActiveSupport::TestCase
    def setup
      @new_patron= patrons(:julieta)
      @coop = stores(:coop)
      @check_in = CheckIn.new(lat: @coop.lat, lng: @coop.lng, patron_id: nil, store_id: nil)

      @check_in_with_patron = CheckIn.new(lat: @coop.lat, lng: @coop.lng, patron_id: @new_patron.id, store_id: nil) 
    end

    test "CheckIn finds a store after updating the patron." do
      @check_in.update_attribute(:patron, @new_patron)
      assert_equal "Julieta", @check_in.patron.first_name
      assert_equal @coop, @check_in.store
      assert_equal :success, @check_in.status
    end

    #Scenario occurs with ambiguous stores.
    test "CheckIn updates the store_id and returns a success status." do
      @check_in_with_patron.update_attribute(:store_id, @coop.id )
      
      assert_equal "Julieta", @check_in_with_patron.patron.first_name
      assert_equal "Linden Hills Coop", @check_in_with_patron.store.name
      assert_equal :success, @check_in_with_patron.status
    end
    
  end
end