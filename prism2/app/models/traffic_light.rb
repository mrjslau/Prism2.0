# TrafficLight model class
class TrafficLight < ApplicationRecord
  belongs_to :intersection

  def change_signal(signal)
    self.signal = signal
  end

  def turn_off
    self.signal = 'none'
    self.blinking = false
  end

  def turn_on
    self.signal = 'red'
    self.blinking = false
  end

  def disable
    self.signal = 'yellow'
    self.blinking = true
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
