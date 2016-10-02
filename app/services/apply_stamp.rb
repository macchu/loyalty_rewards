class ApplyStamp
  def initialize(patron:, store:, check_in=nil)
    check_in ||= CheckIn.create(patron: patron, store: store)
  end
end