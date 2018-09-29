# Implementation of phone entity
class Phone
  attr_accessor :owner, :location, :turned_on, :connected

  def initialize(owner, location)
    @owner = owner
    @location = location
  end

  def turn_on
    @turned_on = true
  end

  def turn_off
    @turned_on = false
  end

  def connect
    if @turned_on
      true
    else
      false
    end
  end

  def listen_call
    if @connected
      true
    else
      false
    end
  end

  def read_messages
    if @connected
      true
    else
      false
    end
  end

  def detect_if_owner_is_near
    @location.calculate_distance(@owner.location) <= 50
  end
end
