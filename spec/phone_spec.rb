# spec/phone_spec.rb

require 'spec_helper.rb'

describe Phone do
  before(:each) do
    @phone = Phone.new(Person.new('John', 'Doe', '39700000001',
                                  Location.new(54.7, 25.3)),
                       Location.new(54.7, 25.3))
  end
  it 'has an owner' do
    expect(@phone.owner.name).to eq 'John'
  end
  it 'has a latitude' do
    expect(@phone.location.latitude).to eq 54.7
  end
  it 'has a longitude' do
    expect(@phone.location.longitude).to eq 25.3
  end

  describe 'phone is near owner' do
    context 'when phone is near owner' do
      it 'should detect that owner has his phone' do
        expect(@phone.detect_if_owner_is_near).to be true
      end
    end
    context 'when phone is 50 meters away from owner' do
      it 'should detect that owner do not have his phone' do
        @phone.owner.location = Location.new(54.8, 25.6)
        expect(@phone.detect_if_owner_is_near).to be false
      end
    end
  end

  describe 'connection' do
    context 'when phone is turned on' do
      before(:each) do
        @phone.turn_on
      end

      it 'should be able to connect to it' do
        expect(@phone.connect).to be true
      end
    end

    context 'when phone is turned off' do
      before(:each) do
        @phone.turn_off
      end

      it 'should not be able to connect to it' do
        expect(@phone.connect).to be false
      end
    end
  end

  describe 'turning on and off' do
    context 'when phone is turned on' do
      before(:each) do
        @phone.turn_on
      end

      it 'should be able to turn off' do
        @phone.turn_off
        expect(@phone.turned_on).to be false
      end
    end

    context 'when phone is turned off' do
      before(:each) do
        @phone.turn_off
      end

      it 'should be able to turn on' do
        @phone.turn_on
        expect(@phone.turned_on).to be true
      end
    end
  end

  describe 'listen call' do
    context 'when connected' do
      before(:each) do
        @phone.turn_on
        @phone.connect
      end
      it 'should be able to listen call' do
        expect(@phone.listen_call).to be true
      end
    end

    context 'when not connected' do
      it 'should not be able to listen to call' do
        expect(@phone.listen_call).to be false
      end
    end
  end

  describe 'read messages' do
    context 'when connected' do
      before(:each) do
        @phone.turn_on
        @phone.connect
      end

      it 'should be able to read messages' do
        expect(@phone.read_messages).to be true
      end
    end

    context 'when not connected' do
      it 'should not be able to read messages' do
        expect(@phone.read_messages).to be false
      end
    end
  end
end
