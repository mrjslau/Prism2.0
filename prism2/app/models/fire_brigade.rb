# FireBrigade model class
class FireBrigade < ApplicationRecord
  belongs_to :map
  belongs_to :neighborhood

  def travel_to(neighborhood)
    self.neighborhood.fire_brigades.delete(id) if self.neighborhood
    self.neighborhood = neighborhood
    self.neighborhood.fire_brigades << self
  end
end
