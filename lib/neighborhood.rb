# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :info, :status, :active_objects

  def initialize(name, city, danger, average_temperature = 19)
    @info = { name: name, city: city }
    @status = { danger: danger, average_temperature: average_temperature }
    @active_objects = { people: [], units: [] }
    @map = Map.instance
  end

  def input_crimes(crimes)
    @status[:danger] += crimes
  end

  def unit_entered(unit)
    @active_objects[:units].push(unit)
  end

  def person_entered(person)
    @active_objects[:people].push(person)
  end

  def change_temperature(celsius)
    @status[:average_temperature] = celsius
    @map.notify_abnormal_temperature(self, celsius) if temp_abnormal?
  end

  def temp_abnormal?
    average_temperature > 35 || average_temperature < -18
  end

  def average_temperature
    @status[:average_temperature]
  end

  def send_police(police_unit)
    police_unit.travel_to(self)
  end

  def send_ambulance(ambulance_unit)
    ambulance_unit.travel_to(self)
  end

  def send_brigade(fire_brigade)
    fire_brigade.travel_to(self)
  end

  def send_drone(drone)
    drone.travel_to(self)
  end
end
