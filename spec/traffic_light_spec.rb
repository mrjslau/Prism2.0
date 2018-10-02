# spec/traffic_light_spec.rb

require 'spec_helper.rb'

describe TrafficLight do
  let(:intersection)  { Intersection.new('Zalgirio-Kalvariju', 4) }
  let(:traffic_light) { TrafficLight.new('Zalgirio-Kalvariju', 1) }

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
  
  describe '#change_status' do
    it 'turns off completely' do
      traffic_light.change_status('off')
      expect(traffic_light.signal).to be_nil
      expect(traffic_light.blinking?).to be(false)
    end
    it 'leaves blinking light' do
      traffic_light.change_status('disable')
      expect(traffic_light.signal).to eq('yellow')
      expect(traffic_light.blinking?).to be(true)
    end
  end
end
