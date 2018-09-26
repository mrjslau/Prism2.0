# lib/ambulance.rb

# Ambulance class represents a medical unit.
# It contains
class Ambulance
  attr_reader :active_neighborhood

  def travel_to(neighborhood)
    @active_neighborhood = neighborhood
    neighborhood.unit_entered(self)
  end
end
