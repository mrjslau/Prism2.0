# lib/drone.rb

# Drone class represents disposable drone with a camera and microphones
# It contains
class Drone
  attr_accessor :active_neighborhood

  def travel_to(neighborhood)
    @active_neighborhood = neighborhood
    neighborhood.unit_entered(self)
  end
end
