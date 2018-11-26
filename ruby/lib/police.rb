# lib/police.rb

# Police class represents a crime solving unit.
# It contains
class Police
  attr_reader :active_neighborhoods, :registered_crimes, :registered_criminals

  def initialize
    @registered_crimes = {}
    @registered_criminals = {}
    @active_neighborhoods = []
  end

  def register_crime(neighborhood, offence_level, person)
    # offence levels:
    #   1 - Petty Misdemeanor
    #   2 - Misdemeanor
    #   3 - Gross Misdemeanor
    #   4 - Felony
    registered_crimes.key?(neighborhood) ||
      (registered_crimes[neighborhood] = [])
    registered_crimes.fetch(neighborhood) << offence_level
    register_criminal(person, offence_level)
    person.identity.add_criminal_record(offence_level, neighborhood)
  end

  def dangerous_neighborhood?(neighborhood)
    if registered_crimes.key?(neighborhood)
      registered_crimes.fetch(neighborhood).length > 5
    else
      false
    end
  end

  def register_criminal(person, offence_level)
    registered_criminals.key?(person) || (registered_criminals[person] = [])
    registered_criminals.fetch(person) << offence_level
  end

  def travel_to(neighborhood)
    active_neighborhoods << neighborhood
    neighborhood.unit_entered(self)
  end
end
