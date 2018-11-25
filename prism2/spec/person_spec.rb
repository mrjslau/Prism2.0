# spec/person_spec.rb

require 'spec_helper.rb'

describe Person do
  fixtures :locations, :identities, :maps, :phones, :pets
  let(:location) { locations(:one) }
  let(:location2) { locations(:two) }
  let(:identity) { identities(:one) }
  let(:pet) { pets(:one) }
  let(:phone) { phones(:one) }
  let(:person) { Person.new }
  let(:map) { maps(:one) }

  before do
    person.location = location
    person.identity = identity
  end

  context 'when person is initialized' do
    it 's name should be' do
      expect(person.identity.name).to eq('Jane')
    end
    it 's surname' do
      expect(person.identity.surname).to eq('Doe')
    end
    it 's identity should be created based on arguments' do
      expect(person.identity.personal_code.to_s[0..6]).to eq('4900101')
    end
  end

  describe '#phones?' do
    context 'when person is created' do
      it 'has a phone' do
        expect(person.phones?).to be false
      end
    end
    
    context 'when a phone is added' do
      it 'is present in persons belongings' do
        person.add_phone(phone)
        expect(person.phones?).to be true
      end
    end

    context 'when phone are removed a person' do
      it 'does not have a phone' do
        person.add_phone(phone)
        person.remove_phones
        expect(person.phones?).to be false
      end
    end
  end

  describe '#add_phone' do
    context 'when a phone is added' do

      it 's owner does not have phone before adding one' do
        expect(person.phones?).to be false
      end
      it 's owner has one phone when it is added' do
        person.add_phone(phone)
        expect(person.phones.length).to be 1
      end
      it 's owner is person' do
        person.add_phone(phone)
        expect(phone.person).to be(person)
      end
    end
  end

  describe '#remove_phones' do
    context 'when phones are removed a person' do
      it 'does not have a phone' do
        person.add_phone(phone)
        person.remove_phones
        expect(person.phones?).to be false
      end
    end
  end

  describe '#near_any_phone?' do
    context 'when person is near phone' do
      it 'person has his phone' do
        phone.location = location
        person.add_phone(phone)
        expect(person.near_any_phone?).to be true
      end
    end

    context 'when person is not near phone' do
      it 'person does not have his phone' do
        phone.location = location2
        person.add_phone(phone)
        expect(person.near_any_phone?).to be false
      end
    end
  end

  describe '#pets?' do
    context 'when person is created' do
      it 'does not have a pet' do
        expect(person.pets?).to be false
      end
    end

    context 'when a pet is added to a person' do
      it 'has a pet' do
        person.add_pet(pet)
        expect(person.pets?).to be true
      end
    end

    context 'when pet is near its owner' do
      it 's owner is near to the pet' do
        pet.location = location
        person.add_pet(pet)
        expect(person.pets.last.detect_if_owner_is_near)
          .to be(true)
      end
    end

    context 'when pets are removed from a person' do
      it 'person does not have a pet' do
        person.add_pet(pet)
        person.remove_pets

        expect(person.pets?).to be false
      end
    end
  end

  describe '#change_location' do
    it 'changes persons latitude ' do
      person.change_location(location2)
      expect(person.location.latitude).to eq(3)
    end
    it 'changes persons longitude' do
      person.change_location(location2)
      expect(person.location.longitude).to eq(3)
    end
  end
end
