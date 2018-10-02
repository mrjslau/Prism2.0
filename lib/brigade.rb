# lib/brigade.rb

# Brigade class represents a fire fighting unit
# It contains
class Brigade
  attr_reader :active_neighborhood

  def initialize(neighborhood = nil)
    @active_neighborhood = neighborhood
  end

  def travel_to(neighborhood)
    @active_neighborhood = neighborhood
    neighborhood.unit_entered(self)
  end
end
