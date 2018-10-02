# lib/map.rb

# Map class is a singleton and represents the main object
#  with which the user will interact.
# It contains
class Map
  attr_reader :notifications, :active_neighborhood

  def initialize
    @notifications = []
    @active_neighborhood = nil
  end

  @instance = Map.new
  class << self
    attr_reader :instance
  end

  def select_neighborhood(neighborhood)
    @active_neighborhood = neighborhood
  end

  def send_police(police_unit, neighborhood)
    police_unit.travel_to(neighborhood)
  end

  def send_ambulance(ambulance_unit, neighborhood)
    ambulance_unit.travel_to(neighborhood)
  end

  def send_brigade(fire_brigade, neighborhood)
    fire_brigade.travel_to(neighborhood)
  end

  def send_drone(drone, neighborhood)
    drone.travel_to(neighborhood)
  end

  def neighborhood_temperature
    @active_neighborhood.average_temperature
  end

  def active_units
    @active_neighborhood.active_units
  end

  def notify_abnormal_temperature(neighborhood, celsius)
    message = "Temperatures have reached: #{celsius} in #{neighborhood.name}!"
    notification = Notification.new(message)
    @notifications.push(notification)

    drone = Drone.new
    drone.travel_to(neighborhood)
  end

  def notify_abnormal_person(person)
    message = "#{person.name} #{person.surname}'s status has changed to:
               #{person.status}!"
    notification = Notification.new(message)
    @notifications.push(notification)
  end
end
