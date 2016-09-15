require 'test_helper'

class DisplayLoyaltyCardTest < ActiveSupport::TestCase
  def setup
    @patron = patrons(:bill)
    @store = stores(:france_44)

    ReceiveEmailService.start
  end

  test 'receives email' do 
    
  end

end