# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :name, :city, :danger, :avg_temperature,
              :cur_temperature, :active_units, :active_people

  def initialize(name, city, danger, avg_temperature = 19)
    @name = name
    @city = city
    @danger = danger
    @avg_temperature = avg_temperature
    @active_units = []
    @active_people = []
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
end