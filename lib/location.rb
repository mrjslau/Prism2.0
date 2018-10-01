# A location class for setting object location.
class Location
  attr_accessor :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  # Calculates distance betwen object with location and given location.
  # Calculation is based on Haversine formula.
  def calculate_distance(location)
    earth_radius = 6_371_000 # earth radius in meters
    radians_per_degree = Math::PI / 180

    lat1_rad = @latitude * radians_per_degree
    lat2_rad = location.latitude * radians_per_degree
    lon1_rad = @longitude * radians_per_degree
    lon2_rad = location.longitude * radians_per_degree

    a = Math.sin((lat2_rad - lat1_rad) / 2)**2 + Math.cos(lat1_rad) *
        Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    earth_radius * c # Delta in meters
  end
end
