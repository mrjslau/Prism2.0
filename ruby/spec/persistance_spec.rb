# spec/persistance_spec.rb

require 'spec_helper.rb'

RSpec::Matchers
  .define :contain_same_notification_messages do |expected_notifications|
  match do |actual_notifications|
    expected_notifications.each_with_index do |notification, index|
      expect(notification.message)
        .to eq(actual_notifications[index].message)
    end
  end
end

RSpec::Matchers.define :contain_same_cities do |expected_cities|
  match do |actual_cities|
    expected_cities.each_with_index do |city, index|
      expect(city.name)
        .to eq(actual_cities[index].name)
      expect(city.neighborhoods)
        .to contain_same_neighborhoods(actual_cities[index].neighborhoods)
      expect(city.buildings).to be_empty
    end
  end
end

RSpec::Matchers.define :contain_same_neighborhoods do |expected_neighborhoods|
  match do |actual_neighborhoods|
    expected_neighborhoods.each_with_index do |neighborhood, index|
      expect(neighborhood.name)
        .to eq(actual_neighborhoods[index].name)
      expect(neighborhood.avg_temperature)
        .to eq(actual_neighborhoods[index].avg_temperature)
      expect(neighborhood.active_objects)
        .to contain_same_active_objects(actual_neighborhoods[index]
          .active_objects)
    end
  end
end

RSpec::Matchers.define :contain_same_active_objects do |expected_active_objects|
  match do |actual_active_objects|
    expect(actual_active_objects.fetch(:people))
      .to be_empty
    expected_active_objects.fetch(:units).each_with_index do |unit, index|
      expect(unit).to be_instance_of(actual_active_objects
        .fetch(:units)[index].class)
    end
  end
end

describe Persistance do
  let(:actual_test_file) { 'actual_test_persistance.yml' }
  let(:expected_test_file) { 'expected_test_persistance.yml' }
  let(:persistance_actual) { described_class.new(actual_test_file) }
  let(:persistance_expected) { described_class.new(expected_test_file) }
  let(:map) { Map.instance }
  let(:location) { Location.new(5, 4) }
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
      expect(loaded_map).to be_instance_of(Map)
    end
    it 'object has empty residents' do
      expect(loaded_map.residents).to be_empty
    end
    it 'object has expected notifications' do
      expect(loaded_map.notifications)
        .to contain_same_notification_messages(map.notifications)
    end
    it 'object has expected cities' do
      expect(loaded_map.cities).to contain_same_cities(map.cities)
    end
    it 'object has expected active_neighborhoods' do
      expect(loaded_map.active_neighborhoods)
        .to contain_same_neighborhoods(map.active_neighborhoods)
    end
  end
end
