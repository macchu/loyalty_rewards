require 'test_helper'

class PatronTest < ActiveSupport::TestCase
  def setup
    @joe = Patron.create(first_name: "Joe", last_name: "Harrison", phone_number: "(612) 581-0000")
  end
  
  test "#find_by_phone_digit_only_phone_number" do
    assert_equal @joe, Patron.find_by_phone("612-581-0000").first
  end

end
