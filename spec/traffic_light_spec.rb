# spec/traffic_light_spec.rb

require 'spec_helper.rb'

describe TrafficLight do
  let(:intersection)  { Intersection.new('Zalgirio-Kalvariju', 4) }
  let(:traffic_light) { TrafficLight.new('Zalgirio-Kalvariju', 1) }
  context 'after initialization' do
    it 'should be' do
      expect(traffic_light.intersection).to eq('Zalgirio-Kalvariju')
      expect(intersection.name).to eq('Zalgirio-Kalvariju')
      expect(traffic_light.number).to be(1)
    end
  end
  describe '#change_signal' do
    it 'changes signal color to red' do
      signal = traffic_light.change_signal('red')
      expect(signal).to eq('red')
    end
    it 'changes signal color to yellow' do
      signal = traffic_light.change_signal('yellow')
      expect(signal).to eq('yellow')
    end
    it 'changes signal color to green' do
      signal = traffic_light.change_signal('green')
      expect(signal).to eq('green')
    end
  end
  describe '#turn_off' do
    it 'turns off completely' do
      light = traffic_light.turn_off
      expect(light).to be(0)
      expect(traffic_light.blinking?(light)).to be(false)
    end
  end
  describe '#disable' do
    it 'leaves blinking light' do
      signal = traffic_light.disable
      expect(signal).to eq('yellow')
      expect(traffic_light.blinking?(signal)).to be(true)
    end
  end
end
