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

  def change_status(status)
    if status == 'off'
      @signal = nil
      @blinking = false
    else
      @signal = 'yellow'
      @blinking = true
    end
  end

  def blinking?
    @blinking
  end
end
