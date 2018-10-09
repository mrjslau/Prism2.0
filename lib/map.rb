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

  def notify_abnormal_temperature(neighborhood, celsius)
    message = "Temperatures have reached: #{celsius}\s
               in #{neighborhood.info[:name]}!"
    notification = Notification.new(message)
    @notifications.push(notification)

    drone = Drone.new
    drone.travel_to(neighborhood)
  end

  def notify_abnormal_person(person)
    message = person.status_change_msg
    notification = Notification.new(message)
    @notifications.push(notification)
  end
end
