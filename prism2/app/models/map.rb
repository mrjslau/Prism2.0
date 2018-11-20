# Main class
class Map < ApplicationRecord
  has_many :people
  has_many :ambulances
  has_many :fire_brigades
  has_many :drones
  has_many :police_units
  has_many :notifications
  has_many :vehicles
end
