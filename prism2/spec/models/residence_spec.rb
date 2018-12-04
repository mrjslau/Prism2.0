require 'rails_helper.rb'

RSpec.describe Residence, type: :model do
  fixtures :residences, :identities, :buildings

  subject(:residence) do
    described_class.new
  end

  let(:b2) { buildings(:b_two) }
  let(:b4) { buildings(:b_four) }
  let(:id1) { identities(:one) }
  let(:id2) { identities(:two) }
  let(:r1) { residences(:r_one) }

  describe '#update_building' do
    context 'when new resident is added' do
      it 'makes building living places decrease' do
        residence.building_id = b2.building_id
        residence.identity_id = id2.personal_code
        expect { residence.save }.to change { residence.building.living_places }
          .from(2).to(1)
      end
    end
  end

  describe '#enough_living_place' do
    it 'adds error if new residence in the building is not possible' do
      residence.building_id = b4.building_id
      residence.identity_id = id2.personal_code
      expect { residence.valid? }
        .to change { residence.errors.messages[:building] }
        .from([]).to(['building is full!'])
    end
    it 'residence is not valid if building is full' do
      residence.building_id = b4.building_id
      residence.identity_id = id2.personal_code
      expect(residence).not_to be_valid
    end
    it 'adds no error message if there are places in the building' do
      residence.building_id = b2.building_id
      residence.identity_id = id2.personal_code
      expect(residence).to be_valid
    end
  end
end
