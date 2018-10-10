# spec/pet_spec.rb

require 'spec_helper.rb'

describe Pet do
  let(:owner) { Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0)) }
  let(:pet)   { described_class.new(owner, Location.new(0, 0))               }

  describe '#change_location' do
    it 'changes pet`s latitude' do
      pet.change_location(0, 50)
      expect(pet.location.latitude).to be(0)
    end
    it 'changes pet`s longitude' do
      pet.change_location(0, 50)
      expect(pet.location.longitude).to be(50)
    end
  end

  describe '#detect_if_owner_is_near' do
    it 'detects if owner is near' do
      expect(pet.detect_if_owner_is_near).to be(true)
    end

    context 'when owner is 49 meters away' do
      it 'detects that that owner is not near' do
        pet.change_location(49, 0)
        expect(pet.detect_if_owner_is_near).to be(true)
      end
    end
    context 'when owner is way further than 50 meters' do
      it 'detects that that owner is not near' do
        pet.change_location(10, 100)
        expect(pet.detect_if_owner_is_near).to be(false)
      end
    end
    context 'when owner is 51 meters far' do
      it 'detects that that owner is not near' do
        pet.change_location(0, 51)
        expect(pet.detect_if_owner_is_near).to be(false)
      end
    end
  end
end
