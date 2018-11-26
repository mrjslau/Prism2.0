# spec/traffic_light_spec.rb

require 'spec_helper.rb'

describe TrafficLight do
  let(:intersection)  { Intersection.new('Zalgirio-Kalvariju', 4)    }
  let(:traffic_light) { described_class.new('Zalgirio-Kalvariju', 1) }

  it 'has a number' do
    expect(traffic_light.number).to be(1)
  end
  it 'belongs to an intersection' do
    expect(traffic_light.intersection).to eq('Zalgirio-Kalvariju')
  end

  describe '#change_signal' do
    it 'changes signal color to red' do
      traffic_light.change_signal('red')
      expect(traffic_light.signal).to eq('red')
    end
    it 'changes signal color to yellow' do
      traffic_light.change_signal('yellow')
      expect(traffic_light.signal).to eq('yellow')
    end
    it 'changes signal color to green' do
      traffic_light.change_signal('green')
      expect(traffic_light.signal).to eq('green')
    end
  end

  describe '#turn_off' do
    before do
      traffic_light.turn_off
    end

    it 'turns off completely' do
      expect(traffic_light.signal).to eq('none')
    end
    it 'does not blink' do
      expect(traffic_light.blinking?).to be(false)
    end
  end

  describe '#turn_on' do
    before do
      traffic_light.turn_on
    end

    it 'changes signal to red' do
      expect(traffic_light.signal).to eq('red')
    end
    it 'does not blink' do
      expect(traffic_light.blinking?).to be(false)
    end
  end

  describe '#disable' do
    before do
      traffic_light.turn_off
    end

    it 'leaves blinking light' do
      traffic_light.disable
      expect(traffic_light.blinking?).to be(true)
    end

    it 'changes signal color to yellow' do
      traffic_light.disable
      expect(traffic_light.signal).to eq('yellow')
    end
  end

  describe '#disabled?' do
    context 'when traffic light is disabled' do
      it 'returns true' do
        expect(traffic_light.disabled?).to be(true)
      end
    end

    context 'when traffic signal is green and blinking' do
      it 'returns false' do
        traffic_light.change_signal('green')
        expect(traffic_light.disabled?).to be(false)
      end
    end

    context 'when traffic signal is yellow and not blinking' do
      it 'returns false' do
        traffic_light.turn_on
        traffic_light.change_signal('yellow')
        expect(traffic_light.disabled?).to be(false)
      end
    end
  end

  describe '#off?' do
    context 'when traffic light is turned off' do
      it 'returns true' do
        traffic_light.turn_off
        expect(traffic_light.off?).to be(true)
      end
    end
  end
end
