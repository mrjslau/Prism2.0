# Implementation of phone entity
class Phone
  attr_reader :owner, :location, :turned_on, :connected

  def initialize(owner, location)
    @owner = owner
    @location = location
    @turned_on = false
    @connected = false
  end

  def turn_on
    @turned_on = true
  end

  def turn_off
    @turned_on = false
  end

  def connect
    @connected = @turned_on
  end

  def listen_call
    @connected
  end

  def read_messages
    @connected
  end

  def detect_if_owner_is_near
    @location.calculate_distance(@owner.location) <= 50
  end
end
