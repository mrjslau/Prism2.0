# spec/pet_spec.rb

require 'spec_helper.rb'

describe Pet do
  let(:owner) { Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0)) }
  let(:pet)   { described_class.new(owner, owner.details[:location])         }

  describe '#detect_if_owner_is_near' do
    it 'detects if owner is near' do
      expect(pet.detect_if_owner_is_near).to be(true)
    end
  end
end
