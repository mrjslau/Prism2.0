# lib/traffic_light.rb

# TrafficLight class...
# it...
class TrafficLight
  attr_reader :intersection, :number, :signal, :blinking

  def initialize(intersection, number)
    @intersection = intersection
    @number = number
    @signal = 'yellow'
    @blinking = true
  end
end
