require 'rails_helper'

RSpec.describe Identity, type: :model do
  fixtures :neighborhoods, :people, :identities, :maps,
           :locations, :criminal_records

  subject(:identity) do
    described_class.new(full_name: identities(:one).full_name,
                        gender: identities(:one).gender,
                        birthday: Date.parse('Jan 01 1990'),
                        person: person)
  end

  let(:neighborhood)    { neighborhoods(:one)    }
  let(:criminal_record) { criminal_records(:one) }
  let(:location)        { locations(:one)        }
  # let(:identity)        { identities(:one)       }
  let(:identity2)       { identities(:two)       }
  let(:map)             { maps(:one)             }
  let(:person)          { people(:three)         }
  let(:person2)         { people(:two)           }

  before do
    identity.save
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(identity).to be_valid
    end

    it 'is not valid without a full name' do
      identity.full_name = nil
      expect(identity).not_to be_valid
    end

    it 'is not valid without a gender from list' do
      identity.gender = 'dog'
      expect(identity).not_to be_valid
    end

    it 'is not valid without a birthday' do
      identity.birthday = nil
      expect(identity).not_to be_valid
    end
  end

  describe '#name' do
    it 'returns first name' do
      expect(identity.name).to eq('Jane')
    end
  end

  describe '#surname' do
    it 'returns surname' do
      expect(identity.surname).to eq('Doe')
    end
  end

  describe '#add_criminal_record' do
    it 'adds a criminal record to identity`s criminal records' do
      identity.add_criminal_record(criminal_record)
      expect(identity.criminal_records.first).to eq(criminal_record)
    end
  end

  describe '#criminal_status' do
    context 'when crimes adds up criminal status changes' do
      it 'is suspicious when person participated in 1 crime' do
        1.times do
          identity.add_criminal_record(criminal_record)
        end
        expect(identity.criminal_status).to eq('suspicious')
      end
      it 'is still suspicious when person participated in 5 crimes' do
        5.times do
          identity.add_criminal_record(criminal_record)
        end
        expect(identity.criminal_status).to eq('suspicious')
      end
      it 'is dangerous when person participated in 6 crimes' do
        6.times do
          identity.add_criminal_record(criminal_record)
        end
        expect(identity.criminal_status).to eq('dangerous')
      end
      it 'is dangerous when more than 5 crimes adds up' do
        7.times do
          identity.add_criminal_record(criminal_record)
        end
        expect(identity.criminal_status).to eq('dangerous')
      end
    end

    context 'when person has no crimes' do
      it 'is normal' do
        expect(identity.criminal_status).to eq('normal')
      end
    end
  end

  describe '#status_change_msg' do
    it 'returns status message' do
      expect(identity.status_change_msg)
        .to eq("Jane Doe's criminal status changed to: normal!")
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
      human = person
      expect(human.identity.person).to be(human)
    end
  end
end
