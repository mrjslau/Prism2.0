# spec/identity_spec.rb

require 'spec_helper.rb'

describe Identity do
  Map.instance.cities.clear
  let(:city) { City.new('Panevezys') }
  let(:neighborhood) { Neighborhood.new('Klaipeda', city) }
  let(:person) do
    Person.new('John', 'Siva', 'male', '1996-05-17',
               Location.new(25, 25))
  end
  let(:identity) { person.identity }
  let(:building) do
    Buildings.new(Location.new(13, 5), 'residential', 5, 5, neighborhood)
  end
  let(:map) { Map.instance }

  context 'when person is initialized, his identity is too' do
    it 'gets name from an argument list' do
      expect(person.identity.full_name[:name]).to eq('John')
    end
    it 'gets surname from an argument list' do
      expect(person.identity.full_name[:surname]).to eq('Siva')
    end
    it 'for man generated personal code starts with 3' do
      expect(person.identity.personal_code[0]).to eq('3')
    end
    it 'stars with 4 for females' do
      female = Person.new('John', 'Siva', 'female', '1996-05-17',
                          Location.new(25, 25))
      expect(female.identity.personal_code).to eq('49605170000')
    end
    it 'does not have residence when initialized' do
      expect(person.identity.criminal_records).to eq([])
    end
  end

  context 'when residence id added to the person' do
    it 'changes person.identity residence to added building info' do
      person.identity.add_residence(building)
      expect(person.identity.residence).to be(building)
    end
  end

  context 'when residence is deleted' do
    it 'assigns nil to all residence values' do
      person.identity.add_residence(building)
      person.identity.remove_residence
      expect(person.identity.residence).to be_nil
    end
  end

  context 'when second identity is created with the same birth date ' do
    it 'adds 1 to the already existing personal_code' do
      last_person_alike = person.identity.personal_code
      new_identity = described_class.new('Tom', 'Sue', 'male', '1996-05-17')
      expect(new_identity.personal_code)
        .to eq((last_person_alike.to_i + 1).to_s)
    end
  end

  describe '#name' do
    it 'returns persons name' do
      expect(person.identity.name).to eq('John')
    end
  end

  describe '#surname' do
    it 'returns persons surname' do
      expect(person.identity.surname).to eq('Siva')
    end
  end

  describe '#status_change_message' do
    it 'returns message about persons status' do
      expect(person.identity.status_change_msg).to eq("John Siva's criminal" \
' status changed to: normal!')
    end
  end

  describe '#criminal_status' do
    context 'when there is no criminal records registered' do
      it 'is normal' do
        expect(identity.criminal_status).to eq('normal')
      end
    end
    context 'when crimmes adds up criminal status changes' do
      it 'is suspicious when person participated in 1 crime' do
        1.times do
          identity.add_criminal_record(2, neighborhood)
        end
        expect(identity.criminal_status).to eq('suspicious')
      end
      it 'is still suspicious when person participated in 5 crimes' do
        5.times do
          identity.add_criminal_record(2, neighborhood)
        end
        expect(identity.criminal_status).to eq('suspicious')
      end
      it 'is dangerous when person participated in 6 crimes' do
        6.times do
          identity.add_criminal_record(2, neighborhood)
        end
        expect(identity.criminal_status).to eq('dangerous')
      end
      it 'is dangerous when more than 5 crimes adds up' do
        7.times do
          identity.add_criminal_record(2, neighborhood)
        end
        expect(identity.criminal_status).to eq('dangerous')
      end
    end
  end

  describe '#person' do
    it 'returns person to which this identity belongs' do
      expect(identity.person).to be(person)
    end
    it 's returned person identity is same identity from which it was called' do
      expect(identity.person.identity).to be(identity)
    end
    it 'from new identity it still returns owner of new identity' do
      human = Person.new('Gale', 'Gy', 'female', '1985-08-09',
                         Location.new(5, 5))
      expect(human.identity.person).to be(human)
    end
  end

  context 'when criminal record is added' do
    it 'is be pushed to the criminal_records array' do
      identity.criminal_records.clear
      identity.add_criminal_record(2, neighborhood)
      expect(identity.criminal_records.last)
        .to eq(offence_level: 2, neighborhood: neighborhood)
    end
    it 'does not notify when person has less than 5 records' do
      notification_count = map.notifications.length
      identity.add_criminal_record(2, neighborhood)
      expect(map.notifications.length).to be(notification_count)
    end
    it 'does notify when person has criminal 6 records' do
      notification_count = map.notifications.length
      6.times do
        identity.add_criminal_record(2, neighborhood)
      end
      expect(map.notifications.length).to be(notification_count + 1)
    end
    it 'does notify when person has more than 5 records' do
      notification_count = map.notifications.length
      7.times do
        identity.add_criminal_record(2, neighborhood)
      end
      expect(map.notifications.length).to be(notification_count + 2)
    end
  end
end
