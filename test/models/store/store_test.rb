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

  test ".find_by_email_for_check_ins" do
    assert_equal @coop, Store.find_by_email_for_check_ins('linden_hills_coop@stampstamp.com')
  end

  test "one store found" do
    
  end

  test "multiple stores found" do

  end

  test "Returns a redemption_code_type when one is defined." do
    assert_equal "QCode", @coop.redemption_code_type.description
  end
end
