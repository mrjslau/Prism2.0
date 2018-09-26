# lib/police_repository.rb

# PoliceRepository class is acting as a database
# for the Police entity
# It contains
class PoliceRepository
  def get
    Police.new
  end
end
