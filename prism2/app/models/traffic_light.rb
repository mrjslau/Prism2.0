# TrafficLight model class
class TrafficLight < ApplicationRecord
  belongs_to :intersection

  def change_signal(signal)
    @signal = signal
  end

  def turn_off
    @signal = 'none'
    @blinking = false
  end

  def turn_on
    @signal = 'red'
    @blinking = false
  end

  def disable
    @signal = 'yellow'
    @blinking = true
  end

  def blinking?
    blinking
  end

  def disabled?
    signal.eql?('yellow') && blinking?
  end

  def off?
    signal.eql?('none')
  end
end
