# spec/vehicle_spec.rb

require 'spec_helper.rb'

describe Vehicle do
  let(:location1) { Location.new(55, 25.3) }
  let(:location2) { Location.new(54.7, 25.3) }
  let(:person)    do
    Person.new('John', 'Doe', 'Male', '1984-07-08', Location.new(54.7, 25.3))
  end
  let(:vehicle) { described_class.new('ABC-123', person, location2) }

  it 'has a licence number' do
    expect(vehicle.licence_number).to eq 'ABC-123'
  end

  it 'has an owner' do
    expect(vehicle.owner).not_to be nil
  end

  it 'has a location' do
    expect(vehicle.location).not_to be nil
  end

  describe '#drive_to' do
    context 'when moving' do
      it 'changes location' do
        vehicle.drive_to(location1)
        expect(vehicle.location.to_s).not_to eq '[54.7, 25.3]'
      end
      it '' do
        vehicle.drive_to(location1)
        expect(vehicle.location).to eq(location1)
      end
    end
  end

  describe '#check_if_owner_is_driving' do
    context 'when owner is driving' do
      it 'confirms that owner is in the car' do
        expect(vehicle.check_if_owner_is_driving).to be true
      end
    end

    context 'when owner is not driving' do
      it 'confirms that owner is not in the car' do
        vehicle.owner.change_location(Location.new(54.6, 25.1))
        expect(vehicle.check_if_owner_is_driving).to be false
      end
    end
  end
end
