# lib/police.rb

# Police class represents a crime solving unit.
# It contains
class Police
  attr_reader :active_neighborhood, :registered_crimes

  def initialize
    @registered_crimes = {}
  end

  def register_crime(neighbourhood, offence_level)
    # offence levels:
    #   1 - Petty Misdemeanor
    #   2 - Misdemeanor
    #   3 - Gross Misdemeanor
    #   4 - Felony
    unless @registered_crimes.key?(neighbourhood)
      @registered_crimes[neighbourhood] = []
    end
    @registered_crimes[neighbourhood] << offence_level
  end

  def dangerous_neighbourhood?(neighbourhood)
    if @registered_crimes.key?(neighbourhood)
      @registered_crimes[neighbourhood].length > 5
    else
      false
    end
  end

  def travel_to(neighborhood)
    @active_neighborhood = neighborhood
    neighborhood.unit_entered(self)
  end
end
