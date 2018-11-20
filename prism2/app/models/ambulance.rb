# Ambulance model class
class Ambulance < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood = neighborhood
  end
end
