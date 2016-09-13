require 'test_helper'

class CheckInsControllerTest
  class SelectStore < ActionDispatch::IntegrationTest
    def setup
      @coop = stores(:coop)
      @france_44 = stores(:france_44)
      @patron = patrons(:julieta)
      @check_in = CheckIn.create(phone_number: "987-650-4444", lat: @coop.lat, lng: @coop.lng, patron: @patron, store_id: nil)
    end

    test "a store is linked to a check_in" do 
      post '/check_ins/ambiguous_store', params: {  check_in_id: @check_in.id, store: @france_44.id }

      assert_response :success
      assert_equal @france_44.name, CheckIn.last.store.name
    end
  end
end 