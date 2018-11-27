require 'rails_helper.rb'

RSpec.describe Phone, type: :model do
  fixtures :phones, :locations
  let(:location1) { locations(:one)                 }
  let(:location2) { locations(:two)                 }
  let(:person)    { Person.new(location: location2) }
  let(:phone)     { phones(:nokia)                  }

  before do
    phone.person = person
    phone.location = Location.new(longitude: 0, latitude: 0)
  end

  describe '#change_location' do
    it 'changes phone`s latitude' do
      phone.change_location(0.05, 0)
      expect(phone.location.latitude).to be(0.05)
    end
    it 'changes phone`s longitude' do
      phone.change_location(0, 0.05)
      expect(phone.location.longitude).to be(0.05)
    end
  end

  describe '#detect_if_owner_is_near' do
    it 'detects if owner is near' do
      expect(phone.detect_if_owner_is_near).to be(true)
    end

    context 'when owner is 50 meters away' do
      it 'detects that that owner is near' do
        phone.change_location(0.0004, 0.0002)
        expect(phone.detect_if_owner_is_near).to be(true)
      end
    end

    context 'when owner is further than 50 meters' do
      it 'detects that that owner is not near' do
        phone.change_location(0.0005, 0)
        expect(phone.detect_if_owner_is_near).to be(false)
      end
    end

    context 'when owner is exactly 51 meters far' do
      it 'detects that that owner is not near' do
        phone.change_location(0.00045, 0)
        expect(phone.detect_if_owner_is_near).to be(false)
      end
    end
  end

  describe '#connect' do
    context 'when phone is turned on' do
      before do
        phone.turn_on
      end

      it 'is able to connect to it' do
        phone.connect
        expect(phone.connected).to be true
      end
    end

    context 'when phone is turned off' do
      before do
        phone.turn_off
      end

      it 'is not able to connect to it' do
        expect(phone.connect).to be false
      end
    end
  end

  describe '#turn_off' do
    context 'when phone is turned on' do
      before do
        phone.turn_on
      end

      it 'is able to turn off' do
        phone.turn_off
        expect(phone.turned_on).to be false
      end
    end
  end

  describe '#turn_on' do
    context 'when phone is turned off' do
      before do
        phone.turn_off
      end

      it 'is able to turn on' do
        phone.turn_on
        expect(phone.turned_on).to be true
      end
    end
  end

  describe '#listen_call' do
    context 'when connected' do
      before do
        phone.turn_on
        phone.connect
      end

      it 'is able to listen to a call' do
        expect(phone.listen_call).to be true
      end
    end

    context 'when not connected' do
      it 'is not able to listen to a call' do
        expect(phone.listen_call).to be false
      end
    end
  end

  describe '#read_messages' do
    context 'when connected' do
      before do
        phone.turn_on
        phone.connect
      end

      it 'is able to read messages' do
        expect(phone.read_messages).to be true
      end
    end

    context 'when not connected' do
      it 'is not able to read messages' do
        expect(phone.read_messages).to be false
      end
    end
  end
end
