# PoliceUnit model class
class PoliceUnit < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood = neighborhood
  end
end
