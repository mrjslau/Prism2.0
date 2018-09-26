# lib/ambulance_repository.rb

# AmbulanceRepository class is acting as a database
# for the Ambulance entity
# It contains
class AmbulanceRepository
  def get
    Ambulance.new
  end
end
