# spec/phone_spec.rb

require 'spec_helper.rb'

describe Phone do
  let(:location1) { Location.new(54.7, 25.3)                            }
  let(:location2) { Location.new(54.7, 25.3)                            }
  let(:person)    { Person.new('John', 'Doe', '39700000001', location1) }
  let(:phone)     { described_class.new(person, location2)              }

  it 'has an owner' do
    expect(phone.owner.personal_information[:name]).to eq 'John'
  end
  it 'has a latitude' do
    expect(phone.location.latitude).to eq 54.7
  end
  it 'has a longitude' do
    expect(phone.location.longitude).to eq 25.3
  end

  describe '#detect_if_owner_is_near' do
    context 'when phone is near owner' do
      it 'detects that owner has his phone' do
        expect(phone.detect_if_owner_is_near).to be true
      end
    end
    context 'when phone is 50 meters away from owner' do
      it 'detects that owner does not have his phone' do
        phone.owner.change_location(Location.new(54.8, 25.6))
        expect(phone.detect_if_owner_is_near).to be false
      end
    end
  end

  describe '#connect' do
    context 'when phone is turned on' do
      before do
        phone.turn_on
      end

      it 'is able to connect to it' do
        expect(phone.connect).to be true
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
