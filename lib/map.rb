# lib/map.rb

# Map class is a singleton and represents the main object
#  with which the user will interact.
# It contains
class Map
  attr_reader :notifications, :active_neighborhood, :cities, :residents

  def initialize
    @notifications = []
    @active_neighborhood = nil
    @cities = []
    @residents = []
  end

  def self.instance
    @instance ||= new
  end

  def select_neighborhood(neighborhood)
    @active_neighborhood = neighborhood if
        neighborhood.instance_of?(Neighborhood)
  end

  def send_police(police_unit, neighborhood)
    police_unit.travel_to(neighborhood) if
        police_unit.instance_of?(Police) && neighborhood.instance_of?(Neighborhood)
  end

  def send_ambulance(ambulance_unit, neighborhood)
    ambulance_unit.travel_to(neighborhood) if
        ambulance_unit.instance_of?(Ambulance) && neighborhood.instance_of?(Neighborhood)
  end

  def send_brigade(fire_brigade, neighborhood)
    fire_brigade.travel_to(neighborhood) if
        fire_brigade.instance_of?(Brigade) && neighborhood.instance_of?(Neighborhood)
  end

  def send_drone(drone, neighborhood)
    drone.travel_to(neighborhood) if
        drone.instance_of?(Drone) && neighborhood.instance_of?(Neighborhood)
  end

  def active_units
    @active_neighborhood.active_units if
        @active_neighborhood.instance_of?(Neighborhood)
  end

  def notify_temp_anomaly(neighborhood, cur_temperature, avg_temperature)
    difference = (cur_temperature - avg_temperature).abs
    message = "Temperatures have reached: #{cur_temperature} in " \
              "#{neighborhood.name}! The difference from the average " \
              "temperature is #{difference} degrees!"
    @notifications << Notification.new(message)
    send_drone(Drone.new, neighborhood)
  end

  def notify_abnormal_person(person)
    @notifications << Notification.new(person.status_change_msg)
  end
end
