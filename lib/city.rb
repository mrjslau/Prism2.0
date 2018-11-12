# lib/city.rb

# City class is the main program class
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

  def gen_building_id(type, floors, neighborhood)
    # generates 10 digit id number, where 1st number defines type
    # 2nd and 3rd numbers define city id
    # 4th and 5th numbers define neighborhood index in the city
    # 6th and 7th numbers define floors
    id = (
    ((type.eql?('residential') ? 3 : 2
     ) * 100 + idx
    ) * 100 + neighborhood.idx_in_city) * 100 + floors
    idx_last = fetch_last_id_idx(id) || true
    (idx_last.instance_of?(TrueClass) ? (id * 1000) : old_combo(idx_last)).to_s
  end

  def fetch_last_id_idx(id)
    buildings.rindex do |building|
      building.id.start_with?(id.to_s)
    end
  end

  def old_combo(idx)
    Integer(buildings.fetch(idx).id) + 1
  end
end
