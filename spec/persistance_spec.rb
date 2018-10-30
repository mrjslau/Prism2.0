# spec/persistance_spec.rb

require 'spec_helper.rb'

describe Persistance do
  let(:actual_test_file) { 'actual_test_persistance.yml' }
  let(:expected_test_file) { 'expected_test_persistance.yml' }
  let(:persistance_actual) { described_class.new(actual_test_file) }
  let(:persistance_expected) { described_class.new(expected_test_file) }
  let(:map) { Map.instance }
  let(:location) { Location.new(5, 4) }
  let(:person) do
    Person.new('Jane', 'Doe', 'female', '1990-06-03', location)
  end
  let(:city) { City.new('Vilnius') }
  let(:neighborhood) { Neighborhood.new('Baltupiai', city, 2) }

  describe '#store_data' do
    it 'stores map to file' do
      persistance_actual.store_data(map)
      expect(File.open(actual_test_file, 'rb').read).to eq(
        File.open(expected_test_file, 'rb').read
      )
    end
  end

  describe '#fetch_data' do
    let(:loaded_map) { persistance_expected.fetch_data }

    it 'fetches object of type Map from file' do
      expect(loaded_map.instance_of?(Map)).to be(true)
    end
    it 'object has empty notifications' do
      expect(loaded_map.residents).to eq([])
    end
  end
end
