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

  class ContextPatronOfMultipleStores < ActiveSupport::TestCase
    def setup
      @bill = patrons(:bill)

      #Hardcode the first cards stamp count.
      @card_1 = @bill.loyalty_cards.first
      @card_1.update_attribute(:stamp_count, 3)

      @card_2 = @bill.loyalty_cards.last

      @store_1 = @card_1.store
      @store_2 = @card_2.store
    end

    test "setup" do
      assert @bill.loyalty_cards.count > 1
      refute @store_1 == @store_2
    end

    test "#stamp_count_for_store" do
      stamp_count = @bill.stamp_count_for_store(@store_1)
      assert_equal 3, stamp_count
    end

    test "#current_loyalty_card_for_store" do
      assert @card_1, @bill.current_loyalty_card_for_store(@store_1)
      assert @card_2, @bill.current_loyalty_card_for_store(@store_2)
    end
  end

  class ContextPendingPatron < ActiveSupport::TestCase
    def setup
      @pending_patron = patrons(:pending_patron)
      @store = @pending_patron.stores.first
    end

    test "setup" do
      assert @pending_patron.loyalty_cards.empty?
      assert @store
    end

    test "#stamp_count_for_store" do
      assert_equal 0, @pending_patron.stamp_count_for_store(@store)
    end

    test "#current_loyalty_card_for_store" do
      assert_nil @pending_patron.current_loyalty_card_for_store(@store)
    end
  end
end
