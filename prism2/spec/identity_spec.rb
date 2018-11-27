require 'rails_helper'

RSpec.describe Identity, type: :model do
  fixtures :neighborhoods, :people, :identities, :maps, 
           :locations, :criminal_records
  let(:neighborhood)    { neighborhoods(:one) }
  let(:criminal_record) { criminal_records(:one) }
  let(:location)        { locations(:one) }
  let(:identity)        { identities(:one) }
  let(:identity2)       { identities(:two) }
  let(:map)             { maps(:one) }
  let(:person)          { Person.new }
  let(:person2)         { Person.new }

  before do
    person.identity = identity
    person.location = location
    person2.identity = identity2
    person2.location = location
  end

  context 'when person is initialized, his identity is too' do
    it 'gets name from an argument list' do
      expect(person.identity.name).to eq('Jane')
    end
    it 'gets surname from an argument list' do
      expect(person.identity.surname).to eq('Doe')
    end
    it 'for female generated personal code starts with 4' do
      expect(person.identity.personal_code.to_s[0]).to eq('4')
    end
    it 'stars with 3 for male' do
      expect(person2.identity.personal_code.to_s).to eq('39101011231')
    end
  end

  describe '#name' do
    it 'returns persons name' do
      expect(person.identity.name).to eq('Jane')
    end
  end

  describe '#surname' do
    it 'returns persons surname' do
      expect(person.identity.surname).to eq('Doe')
    end
  end

#   describe '#criminal_status' do
#     context 'when crimmes adds up criminal status changes' do
#       it 'is suspicious when person participated in 1 crime' do
#         1.times do
#           identity.add_criminal_record(criminal_record)
#         end
#         expect(identity.criminal_status).to eq('suspicious')
#       end
#       it 'is still suspicious when person participated in 5 crimes' do
#         5.times do
#           identity.add_criminal_record(criminal_record)
#         end
#         expect(identity.criminal_status).to eq('suspicious')
#       end
#       it 'is dangerous when person participated in 6 crimes' do
#         6.times do
#           identity.add_criminal_record(criminal_record)
#         end
#         expect(identity.criminal_status).to eq('dangerous')
#       end
#       it 'is dangerous when more than 5 crimes adds up' do
#         7.times do
#           identity.add_criminal_record(criminal_record)
#         end
#         expect(identity.criminal_status).to eq('dangerous')
#       end
#     end
#   end

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
