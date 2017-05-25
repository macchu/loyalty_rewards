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

  test "#check_ins_count returns 0 when CheckIns is empty." do
    #Destroy the check ins.
    @coop.check_ins.destroy_all
    assert_equal 0, @coop.check_ins_count
  end

  test "#check_ins_count returns " do
    assert_equal 1, @coop.check_ins_count
  end

  test "#redemptions_count returns 0 when CheckIns is empty." do
    #Destroy the check ins.
    @coop.redemptions.destroy_all
    assert_equal 0, @coop.redemptions_count
  end

  test "#redemptions_count returns 3" do
    assert_equal 3, @coop.redemptions_count
  end
end
