require 'test_helper'

class PatronTest < ActiveSupport::TestCase
  def setup
    @joe = Patron.create(first_name: "Joe", last_name: "Harrison", phone_number: "(612) 581-0000")
    @jill = Patron.create(phone_number: '(952) 839-1234', pending: true)

  end
  
  test "#find_by_phone_digit_only_phone_number" do
    assert_equal @joe, Patron.find_by_phone("612-581-0000").first
  end

  test ".pending" do
    assert_equal @jill, Patron.last
    assert Patron.last.pending
  end

  test ".create_digit_only_phone_number" do
    assert_equal '9528391234', @jill.digit_only_phone_number
  end

  test ".finish_enrollment" do
    @jill.finish_enrollment("Jill", "Johnson")
    refute Patron.find(@jill.id).pending
  end

end
