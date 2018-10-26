# spec/buildings_spec.rb

require 'spec_helper.rb'

describe Building do
  Map.instance.cities.clear
  let(:city) { City.new('Vilnius') }
  let(:city2) { City.new('Alytus') }
  let(:location) { Location.new(5, 6) }
  let(:neighborhood) { Neighborhood.new('Baltupiai', city) }
  let(:neighborhood2) { Neighborhood.new('Seskine', city) }
  let(:neighborhood3) { Neighborhood.new('Dainava', city2) }
  let(:building) do
    described_class.new(Location.new(5, 5.001), 'residential',
                        2, 2, neighborhood)
  end
  let(:person) do
    Person.new('George', 'Smith', 'male', '1972-04-28',
               Location.new(5.0005, 5.003))
  end
  let(:person2) do
    Person.new('Joshua', 'Smith', 'male', '1972-04-28',
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
      expect(neighborhood.city.buildings).to include(building)
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
      described_class.new(location, 'residential', 2, 1, neighborhood3)
    end

    it 'is expected to get particular message' do
      small_building.add_resident(person)
      small_building.add_resident(person2)
      expect(Map.instance.notifications.last.message)
        .to eq('Building is already full.')
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
    neighborhood10 = Neighborhood.new('Visoriai', cty)
    building5 = described_class.new(Location.new(5, 5), 'residential', 2, 2,
                                    neighborhood10)
    it 'returns neighborhood idx in city' do
      expect(building5.idx_in_neighborhood).to be(25)
    end
  end

  describe '#in_neighborhood' do
    it 'returns buildings neighborhood based on its id' do
      expect(building.in_neighborhood).to be(neighborhood)
    end
  end
end
