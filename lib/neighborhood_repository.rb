# lib/neighborhood_repository.rb

# NeighborhoodRepository class is acting as a database
# for the Neighborhood entity
# It contains
class NeighborhoodRepository
  def get
    Neighborhood.new('Baltupiai', 'Vilnius', 2)
  end
end
