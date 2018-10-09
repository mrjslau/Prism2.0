# spec/city_spec.rb

require 'spec_helper.rb'

describe City do
  before(:each) do
    @city = City.new('Vilnius')
  end

  context 'when city is initialized' do
    it 'should have been added to the Map array of cities' do
      expect(Map.instance.cities.last.name).to eq('Vilnius')
    end
    it 'should have appropiatly initialized emergency_services array' do
      expect(@city.emergency_services.length).to be(4)
      expect(@city.emergency_services.fetch(0)).to be_a(Drone)
      expect(@city.emergency_services.fetch(1)).to be_a(Ambulance)
      expect(@city.emergency_services.fetch(2)).to be_a(Police)
      expect(@city.emergency_services.fetch(3)).to be_a(Brigade)
    end
  end

  context 'when building is added to the city' do
    it ' 'do
      buildings_count = @city.buildings.length
      @city.add_neighborhood(Neighborhood.new('Seskine', 'Vilnius'))
      @city.add_building(Location.new(5,5), 'residential', 2, 2,
                         @city.neighborhoods.last)
      expect(@city.buildings.length).to be(buildings_count + 1)
      expect(@city.buildings.last.location.latitude).to be(5)
      expect(@city.buildings.last.living_places).to be(2)
    end
  end

  context 'when the neighborhood is added' do
    it 'should have this neighborhood' do
      @city.add_neighborhood(Neighborhood.new('Santariskes', 'Vilnius', 15))
      expect(@city.neighborhoods.last.name).to eq('Santariskes')
      expect(@city.neighborhoods.last.avg_temperature).to be(15)
      expect(@city.neighborhoods.last.active_units).to be_empty
      expect(@city.neighborhoods.last.active_people).to be_empty
    end
  end

  context 'when we try to add not neighbourhood' do
    it 'should not take it in'do
      neighbourhood_count = @city.neighborhoods.length
      @city.add_neighborhood("hello")
      expect(@city.neighborhoods.length).to be(neighbourhood_count)
    end
  end
end