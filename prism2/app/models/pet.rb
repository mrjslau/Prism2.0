# Pet model class
class Pet < ApplicationRecord
  belongs_to :person
  has_one :location

  def change_location(latitude, longitude)
    location.change_latitude(latitude)
    location.change_longitude(longitude)
  end

  def detect_if_owner_is_near
    location.calculate_distance(owner.location) <= 50
  end
end
