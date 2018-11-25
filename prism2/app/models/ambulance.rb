# Ambulance model class
class Ambulance < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood.ambulances.delete(self.id) if self.neighborhood
    self.neighborhood = neighborhood
    self.neighborhood.ambulances << self
  end
end
