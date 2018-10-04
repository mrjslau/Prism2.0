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
  end

  context 'when the neighborhood is added' do
    it 'should have this neighborhood' do
      @city.add_neighborhood(Neighborhood.new('Santariskes', 'Vilnius', 'Normal', 15))
      expect(@city.neighborhoods.last.name).to eq('Santariskes')
      expect(@city.neighborhoods.last.city).to eq('Vilnius')
      expect(@city.neighborhoods.last.danger).to eq('Normal')
      expect(@city.neighborhoods.last.avg_temperature).to be(15)
      expect(@city.neighborhoods.last.cur_temperature).to be(nil)
    end
  end
end