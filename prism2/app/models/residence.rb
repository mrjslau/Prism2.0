class Residence < ApplicationRecord
  belongs_to :identity, class_name: 'Identity', foreign_key: 'personal_code', optional: true
  belongs_to :building, optional: true
  validates :identity, presence: true, uniqueness: true
  validates :building, presence: true
  validate :enough_living_place
  before_create :update_building

  private

  def update_building
    i = building.living_places - 1
    Building.update(building_id, living_places: i)
  end

  def enough_living_place
    errors.add(:building, 'building is full!') unless building
                                                      .livable_and_not_full?
  end
end
