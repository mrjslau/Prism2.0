require 'haversine'

# A location class for setting object location.
class Location
  # EARTH_RADIUS = 6_371_000 # earth radius in meters
  # RAD_PER_DEGREE = Math::PI / 180

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def change_latitude(latitude)
    @latitude = latitude
  end

  def change_longitude(longitude)
    @longitude = longitude
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
                       location.longitude).to_meters
  end
end
