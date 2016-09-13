require 'test_helper'

class CheckInsControllerTest
  class CreatePatronTest < ActionDispatch::IntegrationTest
    def setup
      @coop = stores(:coop)
      @france_44 = stores(:france_44)
      @check_in = CheckIn.create(phone_number: "987-650-4444", lat: @coop.lat, lng: @coop.lng, patron: nil, store_id: nil)
    end

    test "a patron is enrolled" do 
      assert_difference('Patron.count', 1) do
        post patrons_url, params: { patron: { check_in_id: @check_in.id, phone_number: "987-650-4444", first_name: "George", last_name: "Costelo" } }
        assert_response :success
      end
    end
  end
end 