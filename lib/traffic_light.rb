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

  def change_signal(signal)
    @signal = signal
  end

  def turn_off
    @signal = nil
    @blinking = false
  end

  def disable
    @signal = 'yellow'
    @blinking = true
  end

  def blinking?
    @blinking
  end
end
