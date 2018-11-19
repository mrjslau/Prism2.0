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
    notify_abnormal_temperature(cur_temperature)
  end

  def temp_abnormal?(cur_temperature)
    avg = avg_temperature
    ave = avg
    (cur_temperature - ave).abs > 20
  end

  def notify_abnormal_temperature(cur_temperature)
    !temp_abnormal?(cur_temperature) ||
      (message = "Temperature have reached: #{cur_temperature} in " \
              "#{name}!"
       Map.instance.notifications << Notification.new(message)
       send_drone)
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
end
