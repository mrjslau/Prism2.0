#
class Residence < ApplicationRecord
  belongs_to :identity, optional: true
  belongs_to :building, optional: true, foreign_key: 'building_id'
  validates :identity, presence: true, uniqueness: true
  validates :building, presence: true
  validate :enough_living_place
  before_create :update_building

  private

  def update_building
    i = building.living_places - 1
    building.update(living_places: i)
  end

  def enough_living_place
    errors.add(:building, 'building is full!') unless building
                                                      .livable_and_not_full?
  end
end
