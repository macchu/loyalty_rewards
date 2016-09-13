require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  def setup
    @check_in = check_ins(:coop_with_bill)
    @bill = patrons(:bill)
    @julieta = patrons(:julieta)
    @coop = stores(:coop)
  end

  test ".patron" do
    assert_equal @check_in.patron, @bill
  end

  test ".store" do
    assert_equal @check_in.store, @coop
  end

end
