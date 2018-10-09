# lib/buildings.rb

# Buildings class represents one building in the city
# It contains
class Buildings
  attr_reader :location, :living_places, :residents, :id

  def initialize(location, type, floors, living_places, neighbourhood)
    @location = location
    @id = gen_id(type, floors, neighbourhood)
    @living_places = living_places
    @residents = []
  end

  def add_resident(resident)
    if living_places > 0
      @living_places -= 1
      resident.identity.add_residence(self)
      @residents << resident
    else
      puts 'Building is already full.'
    end
  end

  def remove_resident(person)
    person.identity.remove_residence
    @residents.delete(person)
  end

  private

  def gen_id(type, floors, neighbourhood)
    # generates 9 digit id number, where 1st number defines type
    # 2nd and 3rd numbers define number of floors in the building
    # 4th and 5th numbers define neighbourhood index in the city
    id = 4
    id = 2 if type.casecmp('commercial')
    id = 3 if type.casecmp('residential')
    id = (id * 100 + neighbourhood.idx_in_city) * 100 + floors.to_i
    idx_last = fetch_last_id_idx(id, neighbourhood)
    (idx_last.nil? ? new_combo(id) : old_combo(idx_last, neighbourhood)).to_s
  end

  def fetch_last_id_idx(id, neighbourhood)
    neighbourhood.city.buildings.rindex { |building| building.id.start_with?(id.to_s) }
  end

  def old_combo(idx, neighbourhood)
    neighbourhood.city.buildings.fetch(idx).id.to_i + 1
  end

  def new_combo(id)
    id.to_i * 1000 + 1
  end
end
