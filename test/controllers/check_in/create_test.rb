require 'test_helper'

class CheckInsControllerTest
  class CreateTest < ActionDispatch::IntegrationTest
    def setup
      @coop = stores(:coop)
      @france_44 = stores(:france_44)
      @patron = patrons(:julieta)
      #@check_in = CheckIn.create(phone_number: "987-650-4444", lat: @coop.lat, lng: @coop.lng, patron: nil, store_id: nil)
    end

    test "when an unknown patron checks in, they are asked for their first and last names." do 
      assert_difference('CheckIn.count', 1) do
        post check_ins_url, params: { check_in: { phone_number: "651-457-1234", lat: @france_44.lat, lng: @france_44.lng } }
        assert_response :success
        assert_select("label", "First name")
        assert_select("label", "Last name")
      end
    end

    test "when a known patron checks into an ambiguous location, they a prompted to select a possible store." do 
      assert_difference('CheckIn.count', 1) do
        post check_ins_url, params: { check_in: { phone_number: @patron.phone_number, lat: @france_44.lat, lng: @france_44.lng } }
        assert_response :success
        assert_select("p", "Which store do you want?")
      end
    end
  end
end 