# PoliceStation model class
# It has criminal records,
# it can register crimes and criminals
class PoliceStation < ApplicationRecord
  belongs_to :map
  has_many :criminal_records

  def register_crime(neighborhood, offence_level, person)
    # offence levels:
    #   1 - Petty Misdemeanor
    #   2 - Misdemeanor
    #   3 - Gross Misdemeanor
    #   4 - Felony
    criminal_record = CriminalRecord.new(neighborhood_id: neighborhood.id,
                                         offence_level: offence_level,
                                         identity_id: person.identity.id,
                                         police_station_id: id)
    criminal_records << criminal_record
    person.add_crime(criminal_record)
  end
end
