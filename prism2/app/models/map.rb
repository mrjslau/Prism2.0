# Main class
class Map < ApplicationRecord
  has_many :people
  has_many :ambulances
  has_many :fire_brigades
  has_many :drones
  has_many :police_units
  has_many :notifications
  has_many :vehicles
  has_many :neighborhoods
  has_many :police_stations

  def add_notification(notification)
    notifications << notification
  end

  def delete_all_notifications
    notifications.delete_all
  end
end
