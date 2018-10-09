# spec/person_spec.rb

require 'spec_helper.rb'

describe Person do
  before(:each) do
    @person = Person.new('Jane', 'Doe', 'female', '1992-10-12', Location.new(0, 0))
  end
  context 'after initialization' do
    it 's personal information should be' do
      expect(@person.identity.name).to eq('Jane')
      expect(@person.identity.surname).to eq('Doe')
     # expect(@person.personal_code).to eq('4...')
    end
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
          expect(@person.pets.last.detect_if_owner_is_near).to be(true)
          @person.remove_pets
          expect(@person.pets?).to be false
        end
      end
    end
  end
  describe '#change_status' do
    context 'change person status to Suspicious' do
      it 'should create a notification' do
        notification_count = Map.instance.notifications.length
        expect(@person.status).to eq('Normal')
        @person.change_status('Suspicious')
        expect(@person.status).to eq('Suspicious')
        expect(Map.instance.notifications.length).to be(notification_count + 1)
        expect(@person.status_change_msg).to eq("Jane Doe's status has changed to: Suspicious!")
      end
    end
    context 'change status back to Normal' do
      it 'should make new notifications' do
        notification_count = Map.instance.notifications.length
        expect(@person.status).to eq('Normal')
        @person.change_status('Non-active')
        expect(@person.status).to eq('Non-active')
        expect(Map.instance.notifications.length).to be(notification_count)
      end
    end
  end
  describe '#change_location' do
    it 'location expected' do
      @person.change_location(Location.new(5,6))
      expect(@person.location.latitude).to eq(5)
      expect(@person.location.longitude).to eq(6)
    end
  end
end
