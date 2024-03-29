require 'test_helper'

class RedemptionModelTest < ActiveSupport::TestCase
  def setup
    @redemption = redemptions(:unredeemed)
    @redeemed = redemptions(:redeemed)
    @unredeemed_demo = redemptions(:unredeemed_demo)
  end

  test '#redeem -> redeemed: true, code: <SomeString>, returns :success' do 
    refute @redemption.redeemed?

    assert_equal :success, @redemption.redeem
    
    #@redemption.update_attributes( { redeemed: true, code: '123sdfs' })
    assert @redemption.redeemed?
    assert_equal String, @redemption.code.class
    assert @redemption.code.length > 0
  end

  test '#redeem -> redeemed: true, code: <SomeString>, returns :already_redeemed' do 
    assert @redeemed.redeemed

    assert_equal :already_redeemed, @redeemed.redeem
    
    assert @redeemed.redeemed?
    assert_equal String, @redeemed.code.class
    assert @redeemed.code.length > 0
  end

  test '.is_demo' do
    assert @unredeemed_demo.is_demo
  end

end
