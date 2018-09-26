# lib/drone_repository.rb

# DroneRepository class is acting as a database
# for the Drone entity
# It contains
class DroneRepository
  def get
    Drone.new
  end
end
