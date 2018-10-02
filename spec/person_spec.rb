# spec/person_spec.rb

require 'spec_helper.rb'

describe Person do
  before(:each) do
    @person = Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0))
  end

  describe '#phones?' do
    context 'when person is created' do
      it 'should not have a phone' do
        expect(@person.phones?).to be false
      end
    end
  end

  describe '#add_phone' do
    context 'when a phone is added' do
      it 'should have a phone' do
        @person.add_phone(Location.new(0, 0))
        expect(@person.phones?).to be true
      end
    end
  end

  describe '#remove_phones' do
    context 'when phones are removed a person' do
      it 'should not have a phone' do
        @person.add_phone(Location.new(0, 0))
        @person.remove_phones
        expect(@person.phones?).to be false
      end
    end
  end

  describe '#near_any_phone?' do
    context 'when person is near phone' do
      it 'person has his phone' do
        @person.add_phone(Location.new(0, 0))
        expect(@person.near_any_phone?).to be true
      end
    end
    context 'when person is not near phone' do
      it 'person does not have his phone' do
        @person.add_phone(Location.new(2, 2))
        expect(@person.near_any_phone?).to be false
      end
    end
  end

  describe '#pets?' do
    context 'when person is created' do
      it 'should not have a pet' do
        expect(@person.pets?).to be false
      end
    end
    context 'when a pet is added' do
      it 'should have a pet' do
        @person.add_pet(Location.new(0, 0))
        expect(@person.pets?).to be true
      end
      context 'when pets are removed a person' do
        it 'should not have a pet' do
          @person.add_pet(Location.new(0, 0))
          @person.remove_pets
          expect(@person.pets?).to be false
        end
      end
    end
  end
end
