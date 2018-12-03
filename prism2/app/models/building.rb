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
  validate :enough_space_in_neighborhood, on: :create
  before_validation :init_living_places_if_nil
  before_create :init_building_id

  def livable_and_not_full?
    !living_places.blank? && !living_places.zero?
  end

  def map_id
    neighborhood.map_id
  end

  private

  def enough_space_in_neighborhood
    (last_similar_id % 1000).equal?(999) && errors
      .add(:neighborhood, 'neighborhood is full!')
  end

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
    last_similar_id + 1
  end

  def last_similar_id
    from = (
    (type_no * 1000 + map_id) * 1000 + neighborhood_id) * 1000
    to = from + 999
    last_similar_building = Building.where(building_id: from..to).last
    last_similar_building ? last_similar_building.building_id : from
  end

  def type_no
    if building_type.eql?('commercial')
      5
    elsif building_type.eql?('residential')
      6
    else
      7
    end
  end

  # def last_id(from, to)
  #  last_similar_id = Building.where(building_id: from..to).last
  #  last_similar_id ? last_similar_id.building_id : false
  # end
end
