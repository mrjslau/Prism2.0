# Vehicle class of any type vehicle (car, bus etc.)
class Vehicle
  attr_reader :licence_number, :owner, :driver, :location

  def initialize(licence_number, owner, location)
    @licence_number = licence_number
    @owner = owner
    @location = location
  end

  def drive_to(location)
    @location = location
  end

  def check_if_owner_is_driving
    location.to_s.eql?(owner.location.to_s)
  end
end
