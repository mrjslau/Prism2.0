require 'rails_helper'

RSpec.describe Neighborhood, type: :model do
  fixtures :neighborhoods, :maps, :ambulances

  subject(:neighborhood) do
    described_class.new(name: 'Fabai',
                        active_objects: neighborhoods(:didlaukis).active_objects,
                        map: map)
  end

  let(:map)       { maps(:one)              }
  let(:ambulance) { ambulances(:ambulance2) }

  before do
    neighborhood.save
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(neighborhood).to be_valid
    end

    it 'is not valid without a name' do
      neighborhood.name = nil
      expect(neighborhood).not_to be_valid
    end

    it 'is not valid without a map' do
      neighborhood.map = nil
      expect(neighborhood).not_to be_valid
    end
  end

  describe '#change_temperature' do
    it 'changes temperature' do
      neighborhood.temperature = nil
      neighborhood.change_temperature(25.0)
      expect(neighborhood.temperature).to be(25.0)
    end
    it 'calls notify method if temperature is abnormal' do
      neighborhood.temperature = nil
      neighborhood.change_temperature(45.0)
      expect(neighborhood.map.notifications.first.message)
        .to eq('Temperature has reached: 45.0 in Fabai neighborhood!')
    end
  end

  describe '#unit_entered' do
    it 'adds unit to active objects' do
      neighborhood.unit_entered(ambulance)
      expect(neighborhood.active_objects.fetch(:units).first).to be(ambulance)
    end
  end
end
