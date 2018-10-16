# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :name, :avg_temperature, :active_objects

  def initialize(name, city, average_temperature = 19)
    @name = name
    @avg_temperature = average_temperature
    @active_objects = { people: [], units: [] }
    Map.instance.cities.fetch(city.idx).neighborhoods << self
  end

  def dangerous?
    city.police.dangerous_neighborhood?(self)
  end

  def unit_entered(unit)
    active_objects.fetch(:units) << unit
  end

  def person_entered(person)
    active_objects.fetch(:people) << person if person.instance_of?(Person)
  end

  def change_temperature(cur_temperature)
    Map.instance.notify_abnormal_temperature(self, cur_temperature)
  end

  def temp_abnormal?(cur_temperature)
    avg = avg_temperature
    ave = avg
    (cur_temperature - ave).abs > 20
  end

  def send_police
    city.police.travel_to(self)
  end

  def send_ambulance
    city.ambulance.travel_to(self)
  end

  def send_brigade
    city.brigade.travel_to(self)
  end

  def send_drone
    city.drone.travel_to(self)
  end

  def city_idx
    Map.instance.cities.index { |city| city.neighborhoods.include?(self) }
  end

  def city
    Map.instance.cities.fetch(city_idx)
  end

  def idx_in_city
    city.neighborhoods.index { |found| found.equal?(self) }
  end

  def gen_building_id(type, floors)
    # generates 9 digit id number, where 1st number defines type
    # 2nd and 3rd numbers define number of floors in the building
    # 4th and 5th numbers define neighborhood index in the city
    id = (
    ((type.eql?('residential') ? 3 : 2
     ) * 100 + city_idx
    ) * 100 + idx_in_city) * 100 + floors
    idx_last = fetch_last_id_idx(id) || true
    (idx_last.instance_of?(TrueClass) ? (id * 1000) : old_combo(idx_last)).to_s
  end

  def fetch_last_id_idx(id)
    city.buildings.rindex do |building|
      building.id.start_with?(id.to_s)
    end
  end

  def old_combo(idx)
    Integer(city.buildings.fetch(idx).id) + 1
  end
end
