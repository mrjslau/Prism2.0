# PoliceUnit model class
class PoliceUnit < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood.unit_exited(self) if self.neighborhood
    self.neighborhood = neighborhood
    self.neighborhood.unit_entered(self)
  end
end
