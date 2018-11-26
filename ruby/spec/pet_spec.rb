# spec/pet_spec.rb

require 'spec_helper.rb'

describe Pet do
  let(:owner) do
    Person.new('Jane', 'Doe', 'female', '1980-12-02', Location.new(0, 0))
  end
  let(:pet) { described_class.new(owner, Location.new(0, 0)) }

  describe '#change_location' do
    it 'changes pet`s latitude' do
      pet.change_location(0.05, 0)
      expect(pet.location.latitude).to be(0.05)
    end
    it 'changes pet`s longitude' do
      pet.change_location(0, 0.05)
      expect(pet.location.longitude).to be(0.05)
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
