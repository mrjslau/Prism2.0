# lib/city.rb

# City class is the main program class...
# it contains...
class City
  attr_reader :name, :neighborhoods, :residents, :buildings, :emergency_services

  def initialize(name)
    @name = name
    @neighborhoods = []
    @buildings = []
    @emergency_services = [Drone.new, Ambulance.new, Police.new, Brigade.new]
    Map.instance.cities << self
  end

  def add_neighborhood(neighbourhood)
    @neighborhoods << neighbourhood if neighbourhood.instance_of?(Neighborhood)
  end

  def add_building(location, type, floors, living_places, neighbourhood)
    @buildings << Buildings.new(location, type, floors, living_places,
                                neighbourhood)
  end
end
