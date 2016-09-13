require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup
    @coop = stores(:coop)
    @france_44 = stores(:france_44)
  end

  test "no store found" do 
    store = Store.find_store_for_check_in(1, [100, -100])
    assert_equal store.empty?, true
  end

  test "one store found" do
    
  end

  test "multiple stores found" do

  end
end
