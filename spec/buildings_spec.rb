# spec/buildings_spec.rb

require 'spec_helper.rb'

describe Buildings do
  Map.instance.cities.clear
  let(:city) { City.new('Vilnius') }
  let(:city2) { City.new('Alytus') }
  let(:location) { Location.new(5, 6) }
  let(:neighbourhood) { Neighborhood.new('Baltupiai', city) }
  let(:neighbourhood2) { Neighborhood.new('Seskine', city) }
  let(:neighbourhood3) { Neighborhood.new('Dainava', city2) }
  let(:building) do
    described_class.new(Location.new(5, 5.001), 'residential',
                        2, 2, neighbourhood)
  end
  let(:building2) do
    described_class.new(Location.new(5, 5.008), 'residential',
                        2, 2, neighbourhood)
  end
  let(:building3) do
    described_class.new(Location.new(5, 5), 'residential',
                        2, 2, neighbourhood2)
  end
  let(:building4) do
    described_class.new(Location.new(5, 6), 'residential',
                        2, 2, neighbourhood3)
  end
  let(:person) do
    Person.new('George', 'Smith', 'male', '1972-04-28',
               Location.new(5.0005, 5.003))
  end
  let(:person2) do
    Person.new('Joshua', 'Smith', 'male', '1972-04-28',
               Location.new(5.0005, 5.003))
  end
  let(:person3) do
    Person.new('Mary', 'Cole', 'female', '1972-04-28',
               Location.new(5.0005, 5.003))
  end

  context 'when initialized, according to given arguments' do
    it 's location latitude = 5' do
      expect(building.location.latitude).to be(5)
    end
    it 's id = 3000002000' do
      expect(building.id).to eq('3010002000')
    end
    it 'has 2 living places' do
      expect(building.living_places).to be(2)
    end
    it 'has no residents yet' do
      expect(building.residents).to be_empty
    end
    it 'is added to cities buildings array' do
      expect(neighbourhood.city.buildings).to include(building)
    end
  end

  context 'when new resident is added to the building' do
    it 'ads resident to the residents array' do
      building.add_resident(person)
      expect(building.residents.length).to be(1)
    end
    it 'adds residence to the person' do
      building.add_resident(person)
      expect(person.identity.residence).to be(building)
    end
  end
  context 'when residents are added to a full building' do
    let(:small_building) do
      described_class.new(location, 'residential', 2, 1, neighbourhood3)
    end

    it 'is expected to get particular message' do
      small_building.add_resident(person)
      expect(STDOUT).to receive(:puts).with('Building is already full.')
      small_building.add_resident(person2)
    end
  end

  context 'when resident from the building is removed' do
    it 'removes person from a building' do
      building.add_resident(person)
      building.add_resident(person2)
      resident_count = building.residents.length
      building.remove_resident(person)
      expect(building.residents.length).to be(resident_count - 1)
    end
    it '' do
      building.add_resident(person)
      building.add_resident(person2)
      building.remove_resident(person)
      expect(person.identity.residence).to be_nil
    end
  end

  describe '#idx_in_city' do
    context 'when invoked it returns buildings city idx in Map.instance' do
      i = 'Apl'
      13.times do
        City.new(i)
        i += 'a'
      end
      cit = City.new('Aplinkelis')
      neigh = Neighborhood.new('Aplink', cit)
      buildingapl = described_class.new(location, 'residential', 2, 2, neigh)
      it 's idx in city is eq to 1-2 numbers of an id' do
        expect(buildingapl.idx_in_city).to be(buildingapl.id[1..2].to_i)
      end
    end
  end

  describe '#idx_in_neighbouthood' do
    context 'when invoked it'
    i = 'santa'
    cty = City.new('K')
    25.times do
      i += 'a'
      Neighborhood.new(i, cty)
    end
    neighbourhood10 = Neighborhood.new('Visoriai', cty)
    building5 = described_class.new(Location.new(5, 5), 'residential', 2, 2,
                                    neighbourhood10)
    it 'returns neighbourhood idx in city' do
      expect(building5.idx_in_neighbourhood).to be(25)
    end
  end

  describe '#in_neighbourhood' do
    it 'returns buildings neighbourhood based on its id' do
      expect(building.in_neighbourhood).to be(neighbourhood)
    end
  end
end
