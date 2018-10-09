# spec/vehicle_spec.rb

require 'spec_helper.rb'

describe Vehicle do
  before(:each) do
    @vehicle = Vehicle.new('ABC-123', Person.new('John', 'Doe', 'Male', '1984-07-08',
                                                 Location.new(54.7, 25.3)),
                           Location.new(54.7, 25.3))
  end
  it 'has a licence number' do
    expect(@vehicle.licence_number).to eq 'ABC-123'
  end

  it 'has an owner' do
    expect(@vehicle.owner).not_to be nil
  end

  it 'has a location' do
    expect(@vehicle.location).not_to be nil
  end

  context 'when moving' do
    it 'should change location' do
      location = Location.new(54.005, 25.0005)
      @vehicle.drive_to(location)
      expect(@vehicle.location.to_s).not_to eq '[54.7, 25.3]'
      expect(@vehicle.location).to eq(location)
      out = 'A vehicle with licence numbers ABC-123 is driving to [54.005, 25.0005]
'
      expect { @vehicle.drive_to(Location.new(54.005, 25.0005))}.to output(out).to_stdout
    end
  end

  describe '#check_if_owner_is_driving' do
    context 'when owner is driving' do
      it 'should confirm that owner is in the car' do
        expect(@vehicle.check_if_owner_is_driving).to be true
      end
    end

    context 'when owner is not driving' do
      it 'should confirm that owner is not in the car' do
        @vehicle.owner.change_location(Location.new(54.6, 25.1))
        expect(@vehicle.check_if_owner_is_driving).to be false
      end
    end
  end
end
