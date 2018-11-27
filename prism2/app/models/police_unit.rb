# PoliceUnit model class
class PoliceUnit < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(new_neighborhood)
    neighborhood.unit_exited(self) if neighborhood
    self.neighborhood = new_neighborhood
    neighborhood.unit_entered(self)
  end
end
