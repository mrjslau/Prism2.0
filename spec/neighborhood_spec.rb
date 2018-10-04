# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  let(:city)          { City.new('Vilnius') }
  let(:neighborhood)  { Neighborhood.new('Baltupiai', 'Vilnius', 'Normal') }
  let(:neighborhood2) { Neighborhood.new('Jaruzale', 'Vilnius', 'Normal', 25)}

  context 'when neighbourhood is added to the city' do
    it 'the last city neighbourhood name should equal to the added ones' do
      city.add_neighborhood(neighborhood)
      expect(city.neighborhoods.last.name).to eq('Baltupiai')
      city.add_neighborhood(neighborhood2)
      expect(city.neighborhoods.last.name).to eq('Jaruzale')
    end
  end

  context 'after initialization neighbourhoods' do
    it 'it should have these values' do
      expect(neighborhood2.name).to eq('Jaruzale')
      expect(neighborhood2.city).to eq('Vilnius')
      expect(neighborhood2.danger).to eq('Normal')
      expect(neighborhood2.avg_temperature).to be(25)
      expect(neighborhood.avg_temperature).to be(19)
    end
  end

  context 'after abnormal temperature change' do
    it 'is expected for notification to be sent' do
      temperature = 80
      expect(neighborhood.temp_abnormal?(temperature)).to be(true)
      notification_count = Map.instance.notifications.length
      neighborhood.change_temperature(temperature)
      expect(Map.instance.notifications.length).to be(notification_count + 1)
    end
  end
  describe '#input_crimes' do
    it 'changes crime level to dangerous' do
      neighborhood.input_crimes(15)
      expect(neighborhood.danger).to eq('Dangerous')
    end
    it 'changes crime level to safe' do
      neighborhood.input_crimes(1)
      expect(neighborhood.danger).to eq('Safe')
    end
    it 'changes crime level to normal' do
      neighborhood.input_crimes(3)
      expect(neighborhood.danger).to eq('Normal')
    end
  end
end
