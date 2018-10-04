# lib/city.rb

# City class is the main program class...
# it contains...
class City
  attr_reader :name, :neighborhoods

  def initialize(name)
    @name = name
    @neighborhoods = []
    Map.instance.cities << self
  end

  def add_neighborhood(neighbourhood)
    @neighborhoods << neighbourhood if neighbourhood.instance_of?(Neighborhood)
  end
end
