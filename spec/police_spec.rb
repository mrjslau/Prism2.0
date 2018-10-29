# spec/police_spec.rb

require 'spec_helper.rb'

describe Police do
  let(:city) { City.new('Vilnius') }
  let(:neighborhood) { Neighborhood.new('Tarande', city) }
  let(:person) do
    Person.new('Katie', 'Holmes', 'female', '1992-03-25', Location.new(5, 5))
  end
  let(:police) { city.police }

  describe '#register_criminal' do
    let(:offence_level) { 3 }

    context 'when person did not done any crimes' do
      it 's criminal records is empty' do
        expect(person.identity.criminal_records_no).to be(0)
      end
      it 's not present in polices registered_criminals hash' do
        expect(police.registered_criminals.key?(person)).to be(false)
      end
      it 'neighborhoods are not in registered_crimes hash keys' do
        expect(police.registered_crimes.key?(neighborhood)).to be(false)
      end
    end
    context 'when person performed a crime' do
      it 's _ appears as key in criminal records hash' do
        police.register_crime(neighborhood, 2, person)
        expect(police.registered_criminals.key?(person)).to be(true)
      end
      it 's added to the existing array in hash if it is not 1st' do
        police.register_crime(neighborhood, 2, person)
        police.register_crime(neighborhood, 2, person)
        expect(police.registered_criminals[person].length).to be 2
      end
      it 's offense level and neighborhood appears in criminal_records hash' do
        police.register_crime(neighborhood, 2, person)
        expect(person.identity.criminal_records.last)
          .to eq(offence_level: 2, neighborhood: neighborhood)
      end
      it 'appears as a key in polices registered_criminals hash' do
        police.register_crime(neighborhood, offence_level, person)
        expect(police.registered_criminals[person].last)
          .to be(offence_level)
      end
      it 's neighborhood appears in registered_crimes as key' do
        police.register_crime(neighborhood, offence_level, person)
        expect(police.registered_crimes[neighborhood].last)
          .to be(offence_level)
      end
    end
  end

  describe '#dangerous neighborhood' do
    context 'when >5 crimes are registered it returns true' do
      it 'returns false when no crimes are registered' do
        expect(police.dangerous_neighborhood?(neighborhood)).to be(false)
      end
      it 'returns false when 5 crimes are registered' do
        5.times do
          police.register_crime(neighborhood, 4, person)
        end
        expect(police.dangerous_neighborhood?(neighborhood)).to be(false)
      end
      it 'returns true when 6 and more crimes are registered' do
        6.times do
          police.register_crime(neighborhood, 4, person)
        end
        expect(police.dangerous_neighborhood?(neighborhood)).to be(true)
      end
    end
  end

  context 'when criminal is registered' do
    it 'adds criminal and/or offence level to registered_criminals array' do
      police.register_criminal(person, 3)
      expect(police.registered_criminals[person].last).to be(3)
    end
    it 'adds every persons crime to hash in to different arrays' do
      police.register_criminal(person, 3)
      police.register_criminal(person, 2)
      expect(police.registered_criminals[person].length).to be(2)
    end
    it 'creates different keys for every person in registered_crimes hash' do
      person = Person.new('Jane', 'Smith', 'female', '1997-10-21',
                          Location.new(12, 12))
      police.register_criminal(person, 1)
      expect(police.registered_criminals.key?(person)).to be(true)
    end
  end

  context 'when police is called' do
    it 'travels to active neighborhood' do
      police.travel_to(neighborhood)
      expect(police.active_neighborhoods.last).to be(neighborhood)
    end
    it 'appears in neighborhoods active units' do
      police.travel_to(neighborhood)
      expect(neighborhood.active_objects[:units].last).to be_instance_of(Police)
    end
  end
end
