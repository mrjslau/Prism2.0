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

  def input_crimes(crimes)
    if crimes > 10
      @danger = 'Dangerous'
    elsif crimes < 2
      @danger = 'Safe'
    else
      @danger = 'Normal'
    end
  end
end
