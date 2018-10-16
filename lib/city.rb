# lib/city.rb

# City class is the main program class...
# it contains...
class City
  attr_reader :name, :neighborhoods, :buildings, :emergency_services

  def initialize(name)
    @name = name
    @neighborhoods = []
    @buildings = []
    @emergency_services = { drone: Drone.new, ambulance: Ambulance.new,
                            police: Police.new, brigade: Brigade.new }
    Map.instance.cities << self
  end

  def drone
    emergency_services.fetch(:drone)
  end

  def police
    emergency_services.fetch(:police)
  end

  def ambulance
    emergency_services.fetch(:ambulance)
  end

  def brigade
    emergency_services.fetch(:brigade)
  end

  def idx
    Map.instance.cities.index(self)
  end
end
