require 'rails_helper.rb'

RSpec.describe Pet, type: :model do
  fixtures :pets, :locations
  let(:owner) { Person.new(location: locations(:two)) }
  let(:pet)   { pets(:laika)                          }

  before do
    pet.person = owner
    pet.location = Location.new(latitude: 0, longitude: 0)
  end

  describe '#change_location' do
    it 'changes pet`s latitude' do
      pet.change_location(0.05, 0)
      expect(pet.location.latitude).to be(0.05)
    end

    it 'changes pet`s longitude' do
      pet.change_location(0, 0.05)
      expect(pet.location.longitude).to be(0.05)
    end

    it 'recalculates the location without creating a new location object' do
      mock_loc = mock_model(Location);
      pet.location = mock_loc
      allow(mock_loc).to receive(:[]) { pet }

      expect(mock_loc).to receive(:change_latitude).with(10)
      expect(mock_loc).to receive(:change_longitude).with(10)
      allow(pet).to receive(:change_location).with(10, 10)

      pet.change_location(10, 10)
    end
  end

  describe '#detect_if_owner_is_near' do
    it 'detects if owner is near' do
      expect(pet.detect_if_owner_is_near).to be(true)
    end

    context 'when owner is 50 meters away' do
      it 'detects that that owner is near' do
        pet.change_location(0.0004, 0.0002)
        expect(pet.detect_if_owner_is_near).to be(true)
      end
    end

    context 'when owner is further than 50 meters' do
      it 'detects that that owner is not near' do
        pet.change_location(0.0005, 0)
        expect(pet.detect_if_owner_is_near).to be(false)
      end
    end

    context 'when owner is exactly 51 meters far' do
      it 'detects that that owner is not near' do
        pet.change_location(0.00045, 0)
        expect(pet.detect_if_owner_is_near).to be(false)
      end
    end
  end
end
