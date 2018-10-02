# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :name, :city, :danger, :average_temperature,
              :active_units, :active_people, :map

  def initialize(name, city, danger, average_temperature = 19)
    @name = name
    @city = city
    @danger = danger
    @average_temperature = average_temperature
    @active_units = []
    @active_people = []
    @map = Map.instance
  end

  def input_crimes(crimes)
    @danger = if crimes > 10
                'Dangerous'
              elsif crimes < 2
                'Safe'
              else
                'Normal'
              end
  end

  def unit_entered(unit)
    @active_units.push(unit)
  end

  def person_entered(person)
    @active_people.push(person)
  end

  def change_temperature(celsius)
    @average_temperature = celsius
    @map.notify_abnormal_temperature(self, celsius) if temp_abnormal?
  end

  def temp_abnormal?
    @average_temperature > 35 || @average_temperature < -18
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
