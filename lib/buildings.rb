# lib/buildings.rb

# Buildings class represents one building in the city
# It contains
class Buildings
  attr_reader :location, :living_places, :residents, :id

  def initialize(location, type, floors, living_places, neighbourhood)
    @location = location
    @id = neighbourhood.gen_building_id(type, floors)
    @living_places = living_places
    @residents = []
    neighbourhood.city.buildings << self
  end

  def add_resident(resident)
    if !living_places.zero?
      @living_places -= 1
      resident.identity.add_residence(self)
      residents << resident
    else
      puts 'Building is already full.'
    end
  end

  def remove_resident(person)
    person.identity.remove_residence
    residents.delete(person)
  end

  def in_city
    Map.instance.cities.fetch(idx_in_city)
  end

  def in_neighbourhood
    in_city.neighborhoods.fetch(idx_in_neighbourhood)
  end

  def idx_in_city
    id[1..2].to_i
  end

  def idx_in_neighbourhood
    id[3..4].to_i
  end
end
