# lib/intersection.rb

# Intersection class...
# it contains...
class Intersection
  attr_reader :name, :street_count

  def initialize(name, street_count)
    @name = name
    @street_count = street_count
  end
end
