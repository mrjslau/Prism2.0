# spec/traffic_light_spec.rb

require 'spec_helper.rb'

describe TrafficLight do
  let(:intersection)  { Intersection.new('Zalgirio-Kalvariju', 4)    }
  let(:traffic_light) { described_class.new('Zalgirio-Kalvariju', 1) }

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
      expect(traffic_light.signal).to be_nil
    end
    it 'does not blink' do
      expect(traffic_light.blinking?).to be(false)
    end
  end

  describe '#disable' do
    before do
      traffic_light.disable
    end

    it 'leaves blinking light' do
      expect(traffic_light.blinking?).to be(true)
    end

    it 'changes signal color to yellow' do
      expect(traffic_light.signal).to eq('yellow')
    end
  end
end
