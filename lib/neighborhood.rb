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
    bad = temp_abnormal?(celsius)
    @map.notify_abnormal_temperature(self, celsius) if bad
  end

  def temp_abnormal?(celsius)
    celsius > 35 || celsius < -18
  end
end
