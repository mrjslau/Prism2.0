# Building model class
class Building < ApplicationRecord
  self.primary_key = 'building_id'
  has_many :residence
  has_one :location
  belongs_to :neighborhood
  validates :building_type, presence: true,
                            inclusion: %w[commercial residential public]
  validates :floors, presence: true, numericality: { greater_than: 0 }
  validates :living_places, presence: true
  validate :valid_living_places
  validates :neighborhood, presence: true
  before_validation :init_living_places_if_nil
  before_create :init_building_id

  def livable_and_not_full?
    building_type == 'residential' && living_places > 0
  end

  private

  def init_living_places_if_nil
    self.living_places = 0 if living_places.nil?
  end

  def valid_living_places
    (building_type == 'residential' || living_places.zero?) ||
      errors
        .add(:living_places,
             'non residential building cannot have living place')
  end

  def init_building_id
    self.building_id = generate_building_id
  end

  def generate_building_id
    f = (
    (type_no * 1000 + neighborhood.map.id) * 1000 + neighborhood.id
  ) * 1000
    t = f + 1000
    i = last_as_id(f, t)
    i ||= f
    i + 1
  end

  def type_no
    if building_type == 'commercial'
      5
    else
      building_type == 'residential' ? 6 : 7
    end
  end

  def last_as_id(from, to)
    i = Building.where(building_id: from..to).last
    !i.nil? ? i.building_id : false
  end
end
