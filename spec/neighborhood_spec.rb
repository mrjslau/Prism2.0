# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  let(:city) { City.new('Vilnius') }
  let(:neighbourhood) { Neighborhood.new('Baltupiai', 'Vilnius') }
  let(:neighbourhood2) { Neighborhood.new('Jaruzale', 'Vilnius', 25) }

  context 'when neighbourhood is added to the city' do
    it 'the last city neighbourhood name should equal to the added ones' do
      city.add_neighborhood(neighbourhood)
      expect(city.neighborhoods.fetch(0).name).to eq('Baltupiai')
      city.add_neighborhood(neighbourhood2)
      expect(city.neighborhoods.fetch(1).name).to eq('Jaruzale')
    end
  end

  context 'after initialization neighbourhoods' do
    it 'it should have these values' do
      expect(neighbourhood2.name).to eq('Jaruzale')
      expect(neighbourhood2.avg_temperature).to be(25)
      expect(neighbourhood.avg_temperature).to be(19)
    end
  end

  context 'after abnormal temperature change' do
    it 'is expected for notification to be sent' do
      temperature = 80
      expect(neighbourhood.temp_abnormal?(temperature)).to be(true)
      notification_count = Map.instance.notifications.length
      neighbourhood.change_temperature(temperature)
      expect(Map.instance.notifications.length).to be(notification_count + 1)
    end
  end
  describe '#dangerous>' do
    it 'does not change crime level to dangerous yet' do
      3.times do
        neighbourhood.city.emergency_services[2].register_crime(neighbourhood, 2)
      end
      expect(neighbourhood.dangerous?).to be(false)
    end
    it 'changes crime level to dangerous' do
      7.times do
        neighbourhood.city.emergency_services[2].register_crime(neighbourhood, 3)
      end
      expect(neighbourhood.dangerous?).to be(true)
    end
  end
end
