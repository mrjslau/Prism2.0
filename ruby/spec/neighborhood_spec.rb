# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  before do
    Map.instance.cities.clear
    Map.instance.residents.clear
  end
  let(:city) { City.new('Kaunas') }
  let(:neighborhood1) { described_class.new('Zaliakalnis', city) }
  let(:neighborhood2) { described_class.new('Sanciai', city, 25) }
  let(:person) do
    Person.new('John', 'Weil', 'male', '1985-08-16', Location.new(5, 4))
  end
  let(:map) { Map.instance }

  context 'when neighborhood is initialized' do
    it 's name is taken from the arguments' do
      expect(neighborhood2.name).to eq('Sanciai')
    end
    it 's avg temperature can be default initialized to 19' do
      expect(neighborhood2.avg_temperature).to be(25)
    end
    it 's avg temperature can be taken from the arguments' do
      expect(neighborhood1.avg_temperature).to be(19)
    end
  end

  context 'when temperature is changes' do
    it 'does not send notification if temperature is changed to normal' do
      notification_count = map.notifications.length
      neighborhood2.change_temperature(30)
      expect(map.notifications.length).to be(notification_count)
    end
    it 'sends notification if temperature is changed to abnormal' do
      notification_count = map.notifications.length
      neighborhood1.change_temperature(40)
      expect(map.notifications.length).to be(notification_count + 1)
    end
    it 'sends particular message' do
      msg = 'Temperature have reached: 50 in Sanciai!'
      neighborhood2.change_temperature(50)
      expect(map.notifications.last.message).to eql(msg)
    end
  end

  describe '#temp_abnormal' do
    context 'when current temperature is abnormal ir returns true' do
      it 's false when it is20 degrees lass than/more than average temp' do
        expect(neighborhood1.temp_abnormal?(27)).to be(false)
      end
      it 'is false when difference is 20 degrees' do
        expect(neighborhood1.temp_abnormal?(39)).to be(false)
      end
      it 'is true when difference is 21 degree' do
        expect(neighborhood1.temp_abnormal?(40)).to be(true)
      end
      it 'is true when difference is -21 degree' do
        expect(neighborhood1.temp_abnormal?(-5)).to be(true)
      end
    end
  end

  context 'when method notify_abnormal_temperature is called' do
    it 'pushes new message to notification array and sends the drone' do
      neighborhood1.notify_abnormal_temperature(46)
      expect(map.notifications.last.message)
        .to eql('Temperature have reached: 46 in Zaliakalnis!')
    end
    it 'does not send notification when temperature is normal' do
      notificaton_count = map.notifications.length
      neighborhood1.notify_abnormal_temperature(10)
      expect(map.notifications.length).to be(notificaton_count)
    end
    it 'does send a drone when temperature is not normal' do
      neighborhood1.change_temperature 67
      expect(neighborhood1.active_objects.fetch(:units).length).to be 1
    end
  end
  describe '#dangerous?' do
    it 'does not change crime level to dangerous yet' do
      3.times do
        neighborhood1.city.police.register_crime(neighborhood1, 2, person)
      end
      expect(neighborhood1.dangerous?).to be(false)
    end
    it 'changes crime level to dangerous' do
      7.times do
        neighborhood1.city.police.register_crime(neighborhood1, 3, person)
      end
      expect(neighborhood1.dangerous?).to be(true)
    end
  end

  context 'when emergency unit enters neighbourhood' do
    it 'pushes unit to active_units array' do
      units_count = neighborhood1.active_objects[:units].length
      neighborhood1.unit_entered(city.emergency_services[:police])
      expect(neighborhood1.active_objects[:units].length).to be(units_count + 1)
    end
    it 's pushed unit should be of a particular type' do
      neighborhood1.unit_entered(city.emergency_services[:police])
      expect(neighborhood1.active_objects[:units].last).to be_a(Police)
    end
  end

  context 'when person enters the neighbourhood' do
    it 'adds element of type Person to the array' do
      neighborhood1.person_entered(person)
      expect(neighborhood1.active_objects[:people].last).to be_a(Person)
    end
    it 'can not add element of type not Person' do
      people_count = neighborhood1.active_objects[:people].length
      neighborhood1.person_entered(5)
      expect(neighborhood1.active_objects[:people].length).to be(people_count)
    end
  end

  describe '#city_idx' do
    context 'when called it returns city idx in Map.cities array' do
      it 'if our neighborhood is in first cities array city' do
        expect(neighborhood1.city_idx).to be(0)
      end
      it 'is be equal to city in which neighborhood is created' do
        expect(map.cities[neighborhood1.city_idx]).to be(city)
      end
      it 'changes according to which element from an array we try to get' do
        City.new('Panevezis')
        city2 = City.new('Nida')
        neigh = described_class.new('Senamiestis', city2)
        expect(neigh.city_idx).to be(1)
      end
    end
  end

  describe '#idx_in_city' do
    context 'when called it returns idx in cities neighbourhoods array' do
      it 'returns 1 from second neighborhood added to the city' do
        city.neighborhoods.include?(neighborhood1)
        expect(neighborhood2.idx_in_city).to be(1)
      end
    end
  end

  context 'when ' do
    it 'sends police to a neighbourhood' do
      neighborhood1.send_police
      expect(neighborhood1.active_objects.fetch(:units).length)
        .to be 1
    end

    it 'sends an ambulance to a neighbourhood' do
      neighborhood1.send_ambulance
      expect(neighborhood1.active_objects.fetch(:units).length)
        .to be 1
    end

    it 'sends a fire brigade to a neighbourhood' do
      neighborhood1.send_brigade
      expect(neighborhood1.active_objects.fetch(:units).length)
        .to be 1
    end

    it 'sends a drone to a neighbourhood' do
      neighborhood1.send_drone
      expect(neighborhood1.active_objects.fetch(:units).length)
        .to be 1
    end
  end
end
