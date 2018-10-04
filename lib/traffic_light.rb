# lib/traffic_light.rb

# TrafficLight class...
# it...
class TrafficLight
  attr_reader :intersection, :number, :signal, :blinking

  def initialize(intersection, number)
    @intersection = intersection
    @number = number
    @signal = [0, 'green', 'yellow', 'red']
    @blinking = [false, true]
  end

  def change_signal(signal)
    index = @signal.index { |color| color.eql?(signal) }
    @signal.fetch(index)
  end

  def turn_off
    @signal.fetch(0)
  end

  def disable
    change_signal('yellow')
  end

  def blinking?(signal)
    if @signal.index { |color| color.equal?(signal) }.equal?(2)
      blinking.fetch(1)
    else
      blinking.fetch(0)
    end
  end
end
