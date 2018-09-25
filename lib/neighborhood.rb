# lib/neighborhood.rb

# Neighborhood class is...
# it contains...
class Neighborhood
  attr_reader :name, :city, :danger

  def initialize(name, city, danger)
    @name = name
    @city = city
    @danger = danger
  end
end
