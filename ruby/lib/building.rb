# lib/building.rb

# Buildings class represents one building in the city
# It contains
class Building
  attr_reader :location, :living_places, :residents, :id

  def initialize(location, type, floors, living_places, neighborhood)
    city = neighborhood.city
    @location = location
    @id = city.gen_building_id(type, floors, neighborhood)
    @living_places = living_places
    @residents = []
    city.buildings << self
  end

  def add_resident(resident)
    if !living_places.zero?
      @living_places -= 1
      resident.identity.add_residence(self)
      residents << resident
    else
      Map.instance.notifications << Notification
                                    .new('Building is already full.')
    end
  end

  def remove_resident(person)
    person.identity.remove_residence
    residents.delete(person)
  end

  def in_city
    Map.instance.cities.fetch(idx_in_city)
  end

  def in_neighborhood
    in_city.neighborhoods.fetch(idx_in_neighborhood)
  end

  def idx_in_city
    Integer(id[1..2])
  end

  def idx_in_neighborhood
    Integer(id[3..4])
  end
end
