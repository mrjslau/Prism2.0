class PoliceStation < ApplicationRecord
  belongs_to :map
  has_many :criminal_records

  def register_crime(neighborhood, offence_level, person)
    # offence levels:
    #   1 - Petty Misdemeanor
    #   2 - Misdemeanor
    #   3 - Gross Misdemeanor
    #   4 - Felony
    criminal_records << CriminalRecord.new(neighborhood_id: neighborhood.id,
                                           offence_level: offence_level,
                                           identity_id: person.identity.id,
                                           police_station_id: self.id)

    register_criminal(person, offence_level) if person.identity.criminal_status < offence_level
  end

  def register_criminal(person, offence_level)
    person.identity.criminal_status = offence_level
  end

end
