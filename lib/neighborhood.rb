# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :name, :avg_temperature, :active_units, :active_people

  def initialize(name, city, avg_temperature = 19)
    @name = name
    @avg_temperature = avg_temperature
    @active_units = []
    @active_people = []
    Map.instance.cities.first { |found| found.name.eql?(city) }.neighborhoods << self
  end

  def dangerous?
    city.emergency_services[2].dangerous_neighbourhood?(self)
  end

  def unit_entered(unit)
    @active_units << unit
  end

  def person_entered(person)
    @active_people << person
  end

  def change_temperature(celsius)
    cur_temperature = celsius
    map = Map.instance
    map.notify_temp_anomaly(self, cur_temperature, @avg_temperature) if
        temp_abnormal?(cur_temperature)
  end

  def temp_abnormal?(cur_temperature)
    (cur_temperature - @avg_temperature).abs > 35
  end

  def idx_in_city
    Map.instance.cities.index { |city| city.neighborhoods.include?(self) }
  end

  def city
    Map.instance.cities.fetch(idx_in_city)
  end
end