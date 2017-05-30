require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @sjs = companies(:sjs)


    @store_1 = @sjs.stores.create(name: "Sebastian Joe's in Linden Hills")
    @store_1.save
    @patron_1 = @store_1.patrons.create(company: @sjs)
    @store_2 = @sjs.create_store(name: "Sebastian Joe's in  Uptown")
    @patron_2 = @store_2.patrons.create(company: @sjs)


  end

  test "#patron_count finds patrons for multiple stores" do 
      ap @patron_1
      ap @patron_2
  end
end
