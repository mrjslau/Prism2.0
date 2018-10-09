# spec/buildings_spec.rb

require 'spec_helper.rb'

describe Buildings do
  let(:city)    { City.new('Vilnius') }
  let(:neighbourhood) { Neighborhood.new('Baltupiai', city) }
  let(:building) do
    city.add_building(Location.new(5, 5), 'residential', 2, 2, neighbourhood)
    city.buildings[0]
  end
  let(:person) do
    Person.new('George', 'Smith', 'male', '1972-04-28', Location.new(5.0005, 5.003))
  end
  let(:person2) do
    Person.new('Joshua', 'Smith', 'male', '1972-04-28', Location.new(5.0005, 5.003))
  end
  let(:person3) do
    Person.new('Mary', 'Cole', 'female', '1972-04-28', Location.new(5.0005, 5.003))
  end

  context 'when it is initialized' do
    it 'should initialize to like this' do
      expect(building.location.latitude).to be(5)
      expect(building.id).to eq('30002001')
      expect(building.living_places).to be(2)
      expect(building.residents).to be_empty
    end
  end

  context 'when new resident is added to the building' do
    it 'will change building and resident object' do
      building.add_resident(person)
      expect(building.living_places).to be(1)
      expect(building.residents.length).to be(1)
      expect(person.identity.residence).to be(building)
    end
  end
  context 'when residents are added to a full building' do
    it 'is expected to get particular message' do
      building.add_resident(person)
      building.add_resident(person2)
      expect(STDOUT).to receive(:puts).with('Building is already full.')
      building.add_resident(person3)
    end
  end

  context 'when resident is removed' do
    it '' do
      building.add_resident(person)
      building.add_resident(person2)
      resident_count = building.residents.length
      building.remove_resident(person)
      expect(building.residents.length).to be(resident_count - 1)
      expect(person.identity.residence).to be(nil)
    end
  end


end