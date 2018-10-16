# spec/city_spec.rb

require 'spec_helper.rb'

describe City do
  let(:city) { described_class.new('Vilnius') }

  context 'when city is initialized' do
    it 'has been added to the Map array of cities' do
      expect(Map.instance.cities.include?(city)).to be(true)
    end
    it 'has a name' do
      expect(city.name).to eq('Vilnius')
    end
    it 's neighborhoods array should be empty' do
      expect(city.neighborhoods).to eq []
    end
    it 's buildings array should be empty' do
      expect(city.buildings).to eq []
    end
    it 'has 4 emergency_services array elements' do
      expect(city.emergency_services.length).to be(4)
    end
    it 's drone is Drone' do
      expect(city.drone).to be_a(Drone)
    end
    it 's ambulance is Ambulance' do
      expect(city.ambulance).to be_a(Ambulance)
    end
    it 's police is Police' do
      expect(city.police).to be_a(Police)
    end
    it 's brigade is Brigade' do
      expect(city.brigade).to be_a(Brigade)
    end
  end
  describe '#idx' do
    context 'when its called it returns idx of city in Map.instance.cities'
    it 'returns' do
      expect(Map.instance.cities[city.idx]).to be(city)
    end
  end
end
