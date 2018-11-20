require 'haversine'

# Location model storing coordinates
class Location < ApplicationRecord
  belongs_to :person
  belongs_to :phone
  belongs_to :pet
  belongs_to :vehicle

  def change_latitude(latitude)
    self.latitude = latitude
  end

  def change_longitude(longitude)
    self.longitude = longitude
  end

  def to_s
    '[' + latitude.to_s + ', ' + longitude.to_s + ']'
  end

  # Calculates distance betwen object with location and given location.
  # Calculation is based on Haversine formula.
  def calculate_distance(location)
    Haversine.distance(latitude,
                       longitude,
                       location.latitude,
                       location.longitude).to_meters.ceil
  end
end
