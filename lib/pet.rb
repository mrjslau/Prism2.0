# lib/pet.rb

# Pet class of any type pet (dog, cat etc.)
class Pet
  attr_reader :owner, :location

  def initialize(owner, location)
    @owner = owner
    @location = location
  end

  def change_location(latitude, longitude)
    location.change_latitude(latitude)
    location.change_longitude(longitude)
  end

  def detect_if_owner_is_near
    puts "#{location.calculate_distance(@owner.details[:location])} \n \n"
    puts "#{location.calculate_distance(@owner.details[:location]) <= 50} \n"
    location.calculate_distance(@owner.details[:location]) <= 50
  end
end
