# spec/city_spec.rb

require 'spec_helper.rb'

RSpec::Matchers.define :have_meaningfull_id do |type, floors, neighborhood|
  match do |building|
    type_num = type.eql?('residential') ? 3 : 2
    neighborhood_id = neighborhood1.idx_in_city
    city_id = neighborhood.city_idx

    if building.id.nil?
      false
    else
      building.id == ((((type_num * 100 + city_id
                        ) * 100 + neighborhood_id
                       ) * 100 + floors) * 1000).to_s
    end
  end
end

describe City do
  before do
    Map.instance.cities.clear
  end

  let(:city) { described_class.new('Vilnius') }
  let(:neighborhood1) { Neighborhood.new('Liepkalnis', city) }
  let(:neighborhood2) { Neighborhood.new('Zirmunai', city, 25) }

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

  describe '#fetch-last_id(argument)' do
    context 'when called returns id with same start of last buildings or nil' do
      it 'returns nil if no building id starts with argument' do
        expect(city.fetch_last_id_idx(300)).to be_nil
      end
      it 'returns last id which starts with argument if it exists' do
        Building.new(Location.new(4, 5), 'residential', 4, 4,
                     neighborhood1)
        Building.new(Location.new(4, 5), 'residential', 4, 4,
                     neighborhood1)
        expect(city.fetch_last_id_idx(3_000_004)).to be(1)
      end
      it 'returns nil if no id in the array starts with argument' do
        expect(city.fetch_last_id_idx(2_000_004)).to be_nil
      end
    end
  end

  context 'when new building is added to the city' do
    it 'neighbourhood should generate its id' do
      type = 'residential'
      Building.new(Location.new(5, 5), type, 2, 2, neighborhood1)
      building2 = Building.new(Location.new(5, 5), type, 2, 2, neighborhood1)
      expect(city.gen_building_id(type, 2, neighborhood1))
        .to eq((building2.id.to_i + 1).to_s)
    end
  end

  describe '#gen_building_id' do
    context 'when invoked it generate new building id' do
      it 's generated id for commercial building starts with 2' do
        city = described_class.new('Klaipeda')
        nbhd = Neighborhood.new('Senamiestis', city)
        Building.new(Location.new(5, 4), 'commercial', 2, 2,
                     nbhd)
        expect(city.buildings.last.id).to eq('2000002000')
      end
      it 'adds one to the similar id if it exists' do
        building = Building.new(Location.new(5, 4), 'commercial', 2, 2,
                                neighborhood1)
        expect(city.gen_building_id('commercial', 2, neighborhood1))
          .to eq((building.id.to_i + 1)
                       .to_s)
      end
      it 'generates building id where different digits have meaning' do
        expect(city.gen_building_id('residential', 5, neighborhood1)).to eq((
                (
                ((3 * 100 + city.idx) * 100 + neighborhood1.idx_in_city
                ) * 100 + 5
              ) * 1000).to_s)
      end
      it 's generated ids 1-2 digits mean city index in Maps cities array' do
        city1 = described_class.new('Klaipeda')
        Neighborhood.new('Senamiestis', city)
        Neighborhood.new('Senamiestis', city1)
        expect(city.gen_building_id('residential', 1, neighborhood1)[1..2].to_i)
          .to eq(city.idx)
      end
      it 's generated ids 3-4 digits mean neighborhoods id in the city' do
        Building.new(Location.new(5, 4), 'commercial', 2, 2,
                     neighborhood1)
        expect(city.gen_building_id('residential', 1, neighborhood2)[3..4].to_i)
          .to eq(neighborhood2.idx_in_city)
      end
      it 'adds 1 to the last similar buildings id' do
        building = Building.new(Location.new(5, 4), 'residential', 20, 2,
                                neighborhood1)
        expect(city.old_combo(0)).to eq(building.id.to_i + 1)
      end
      it 'with type, floors and neighbourhood identification in it' do
        type = 'residential'
        floors = 23
        building = Building.new(Location.new(5, 5),
                                type, floors, 2, neighborhood1)
        expect(building).to have_meaningfull_id(type, floors, neighborhood1)
      end
    end
  end
end
