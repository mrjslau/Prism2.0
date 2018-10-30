# spec/map_spec.rb

require 'spec_helper.rb'

describe Map do
  described_class.instance.residents.clear
  described_class.instance.notifications.clear

  let(:map) { described_class.instance }
  let(:location) { Location.new(5, 4) }
  let(:person) do
    Person.new('Jane', 'Doe', 'female', '1990-06-03', location)
  end
  let(:city) { City.new('Vilnius') }
  let(:neighborhood) { Neighborhood.new('Baltupiai', city, 2) }

  context 'when class is initialised' do
    let(:instance) { Class.new(described_class).instance }

    it 'is expected that its notification array will be empty' do
      expect(instance.notifications).to be_empty
    end
    it 'is expected that its active_neighbourhoods array will be empty' do
      expect(instance.active_neighborhoods).to be_empty
    end
    it 'is expected that its cities array will be empty' do
      expect(instance.cities).to be_empty
    end
    it 'is expected that its residents array will be empty' do
      expect(instance.residents).to be_empty
    end
  end

  describe 'Map user can' do
    it 'select an active neighbourhood' do
      map.select_neighborhood(neighborhood)
      expect(map.active_neighborhoods.last).to eql(neighborhood)
    end
    it 'can not select neighbourhood of different than Neighbourhood class' do
      active_length = map.active_neighborhoods.length
      map.select_neighborhood('hello')
      expect(map.active_neighborhoods.length).to be(active_length)
    end

    it "observes a neighbourhood's active emergency response units" do
      map.select_neighborhood(neighborhood)
      neighborhood.send_police
      neighborhood.send_ambulance
      expect(neighborhood.active_objects.fetch(:units))
        .to eql([neighborhood.city.police, neighborhood.city.ambulance])
    end
  end

  context 'when method notify abnormal person is calls' do
    it 'adds message of type Notification to the notification array' do
      map.notify_abnormal_person(person)
      expect(map.notifications.last).to be_a(Notification)
    end
    it 'sends particular personal message' do
      map.notify_abnormal_person(person)
      expect(map.notifications.last.message)
        .to eq("Jane Doe's criminal status changed to: normal!")
    end
  end

  context 'when new person is created map generates unique personal code' do
    it 'does take in to consideration persons sex and birth date' do
      person1 = Person.new('Janet', 'White', 'female', '1990-11-14', location)
      expect(person1.identity.personal_code).to eql('49011140000')
    end
    it 'adds 1 when same sex person born in the same day already exists' do
      person1 = Person.new('Janet', 'White', 'female', '1990-11-13', location)
      expect(map.old_combo(map.residents.index(person1)))
        .to be(person1.identity.personal_code.to_i + 1)
    end
    it 's generated code for males starts with 3' do
      expect(map.personal_code_gen('male', '1990-06-03')).to eq('39006030000')
    end
    it 's generated code for females starts with 4' do
      expect(map.personal_code_gen('female', '1990-11-13'))
        .to eq('49011130001')
    end
    it 'does not take symbols - / . from date' do
      expect(map.personal_code_gen('male', '1990-06-03-'))
        .to eq('39006030000')
    end
    it 'does takes only 6 last digits from the date' do
      expect(map.personal_code_gen('male', '1990-06-033'))
        .not_to eq('390060330000')
    end
  end
end
