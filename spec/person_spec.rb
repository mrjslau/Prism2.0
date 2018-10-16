# spec/person_spec.rb

require 'spec_helper.rb'

describe Person do
  let(:location) { Location.new(5, 6) }
  let(:person) do
    described_class.new('Jane', 'Doe', 'female', '1992-10-12',
                        Location.new(0, 0))
  end
  let(:map) { Map.instance }

  context 'when person is initialized' do
    it 's name should be' do
      expect(person.identity.name).to eq('Jane')
    end
    it 's surname' do
      expect(person.identity.surname).to eq('Doe')
    end
    it 'is added to the Map.instance.residents array' do
      expect(map.residents.include?(person)).to be(true)
    end
    it 's identity should be created based on arguments' do
      expect(person.identity.personal_code[0..6]).to eq('4921012')
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
        person.add_phone(location)
        expect(person.phones?).to be true
      end
    end
    context 'when phone are removed a person' do
      it 'does not have a phone' do
        person.add_phone(location)
        person.remove_phones
        puts person.belongings[:phones]
        expect(person.phones?).to be false
      end
    end
  end

  describe '#add_phone' do
    context 'when a phone is added' do
      let(:phone_loc) { Location.new(0, 0) }

      it 's owner does not have phone before adding one' do
        expect(person.phones?).to be false
      end
      it 's owner has one phone when it is added' do
        person.add_phone(phone_loc)
        expect(person.belongings[:phones].length).to be 1
      end
      it 's owner is person' do
        person.add_phone(phone_loc)
        expect(person.belongings[:phones].last.owner).to be(person)
      end
      it 's location should be phone_loc' do
        person.add_phone(phone_loc)
        expect(person.belongings[:phones].last.location).to be(phone_loc)
      end
      it 's present in persons belongings' do
        person.add_phone(phone_loc)
        expect(person.phones?).to be true
      end
    end
  end

  describe '#remove_phones' do
    context 'when phones are removed a person' do
      it 'does not have a phone' do
        person.add_phone(Location.new(0, 0))
        person.remove_phones
        expect(person.phones?).to be false
      end
    end
  end

  describe '#near_any_phone?' do
    context 'when person is near phone' do
      it 'person has his phone' do
        person.add_phone(Location.new(0, 0))
        expect(person.near_any_phone?).to be true
      end
    end
    context 'when person is not near phone' do
      it 'person does not have his phone' do
        person.add_phone(Location.new(2, 2))
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
        person.add_pet(location)
        expect(person.pets?).to be true
      end
    end
    context 'when pet is neat its owner' do
      it 's owner is near to the pet' do
        person.add_pet(Location.new(0, 0))
        expect(person.belongings[:pets].last.detect_if_owner_is_near)
          .to be(true)
      end
    end
    context 'when pets and phones are removed from a person' do
      it 'initializes belongings to: phones: [], pets: [])' do
        person.add_phone(location)
        person.add_pet(location)
        person.remove_pets
        person.remove_phones
        expect(person.belongings).to eq(phones: [], pets: [])
      end
    end
  end

  context 'when person does not participate in any criminal activity' do
    it 's status is normal' do
      expect(person.status).to eq('normal')
    end
  end

  describe '#change_location' do
    it 'changes persons latitude ' do
      person.change_location(Location.new(5, 6))
      expect(person.location.latitude).to eq(5)
    end
    it 'changes persons longitude' do
      person.change_location(Location.new(5, 6))
      expect(person.location.longitude).to eq(6)
    end
  end
end
