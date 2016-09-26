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

  test "#accepts_nested_attributes_for :patronage_proofs" do
    params = { patron_id: patron.id, store_id: @coop.id, phone_number: '1234567890' }
    params[:patronage_proofs] = { code: 'upc1000'} 
    CheckIn.create(params)

    assert_equal 'upc1000', CheckIn.last.code
  end

end
