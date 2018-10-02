# lib/police.rb

# Police class represents a crime solving unit.
# It contains
class Police
  attr_reader :active_neighborhood

  def initialize(neighborhood = nil)
    @active_neighborhood = neighborhood
  end

  def travel_to(neighborhood)
    @active_neighborhood = neighborhood
    neighborhood.unit_entered(self)
  end
end
