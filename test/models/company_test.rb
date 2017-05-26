require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @sjs = companies(:sjs)


    @store_1 = @sjs.create_store(name: "Sebastian Joe's in Linden Hills")
    @patron_1 = @store_1.create_patron(company: @sjs)
    @store_2 = @sjs.create_store(name: "Sebastian Joe's in  Uptown")
    @patron_2 = @store_2.create_patron(company: @sjs)


  end

  def "#patron_count finds patrons for multiple stores" do 
      ap @patron_1
      ap @patron_2
  end
end
