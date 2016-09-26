require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  def setup
    @check_in = check_ins(:coop_with_bill)
    @bill = patrons(:bill)
    @julieta = patrons(:julieta)
    @coop = stores(:coop)

    @pending_patron = Patron.create(phone_number: '1234567890', pending: true)
  end

  test ".patron" do
    assert_equal @check_in.patron, @bill
  end

  test ".store" do
    assert_equal @check_in.store, @coop
  end

  test "#accepts_nested_attributes_for :patronage_proofs" do
    params = { patron_id: @pending_patron.id, store_id: @coop.id, phone_number: '1234567890' }
    params[:patronage_proof_attributes] = { code: 'upc1000'}
    @check_in = CheckIn.create(params)

    assert_equal @check_in, CheckIn.last
    assert_equal 'upc1000', @check_in.patronage_proof.code
  end

end
