# Vehicle class of any type vehicle (car, bus etc.)
class Vehicle
  attr_reader :licence_number
  attr_accessor :owner, :driver, :location

  def initialize(licence_number, owner, location)
    @licence_number = licence_number
    @owner = owner
    @location = location
  end

  def drive_to(location)
    puts 'A vehicle with licence numbers ' + @licence_number +
         ' is driving to ' + location.to_s
    @location = location
  end

  def check_if_owner_is_driving
    @location.to_s == @owner.location.to_s
  end
end
