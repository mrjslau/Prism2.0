require 'rails_helper'

RSpec.describe PoliceStation, type: :model do
  fixtures :police_stations, :maps, :neighborhoods, :identities

  subject(:police) do
    described_class.new(map: map)
  end

  let(:map)          { maps(:one)                               }
  let(:neighborhood) { neighborhoods(:didlaukis)                }
  let(:identity)     { identities(:one)                         }
  let(:person)       { Person.new(map: map, identity: identity) }

  before do
    police.save
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(police).to be_valid
    end

    it 'is not valid without a map' do
      police.map = nil
      expect(police).not_to be_valid
    end
  end

  describe '#register_crime' do
    it 'adds a crime to criminal records' do
      police.register_crime(neighborhood, 3, person)
      expect(police.criminal_records.first.neighborhood.name)
        .to eq('Didlaukis')
    end
  end
end
