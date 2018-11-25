class CriminalRecord < ApplicationRecord
  belongs_to :police_station
  belongs_to :neighborhood
  belongs_to :identity
end
