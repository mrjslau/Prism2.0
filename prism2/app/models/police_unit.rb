# PoliceUnit model class
class PoliceUnit < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood.police_units.delete(self.id) if self.neighborhood
    self.neighborhood = neighborhood
    self.neighborhood.police_units << self
  end
end
