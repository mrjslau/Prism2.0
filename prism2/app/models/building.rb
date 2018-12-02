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
    living_places > 0
  end

  def map_id
    neighborhood.map.id
  end

  private

  def init_living_places_if_nil
    self.living_places = 0 unless living_places
  end

  def valid_living_places
    (building_type.eql?('residential') || living_places.zero?) ||
      errors
        .add(:living_places,
             'non residential building cannot have living places')
  end

  def init_building_id
    self.building_id = generate_building_id
  end

  def generate_building_id
    from = (
    (type_no * 1000 + map_id) * 1000 + neighborhood_id) * 1000
    to = from + 999
    last_similar_building = Building.where(building_id: from...to).last
    new_id = last_similar_building.building_id if last_similar_building
    new_id ||= from
    new_id + 1
  end

  def type_no
    if building_type.eql?('commercial')
      5
    else
      building_type.eql?('residential') ? 6 : 7
    end
  end

  # def last_id(from, to)
  #  last_similar_id = Building.where(building_id: from..to).last
  #  last_similar_id ? last_similar_id.building_id : false
  # end
end
