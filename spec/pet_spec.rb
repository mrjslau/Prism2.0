# spec/pet_spec.rb

require 'spec_helper.rb'

describe Pet do
  let(:owner) { Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0)) }
  let(:pet)   { Pet.new(owner, owner.location) }

  describe '#detect_if_owner_is_near' do
    it 'should detect if owner is near' do
      expect(pet.detect_if_owner_is_near).to be(true)
    end
  end
  describe '#detect_if_owner_is_near' do
    context 'when per ran away' do
      it 'should detect if owner is away' do
        pet = Pet.new(owner, Location.new(1, 1))
        expect(pet.detect_if_owner_is_near).to be(false)
      end
    end
  end
end
