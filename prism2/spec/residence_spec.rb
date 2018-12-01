require 'rails_helper.rb'

RSpec.describe Residence, type: :model do
  fixtures :residences, :identities, :buildings
  let(:b2) { buildings(:b_two) }
  let(:b4) { buildings(:b_four) }
  let(:id1) { identities(:one) }
  let(:id2) { identities(:one) }
  let(:r1) { residences(:r_one) }

  describe '#update_building' do
    context 'when new resident is added' do
      it 'makes building living places decrease' do
        r = described_class.new(building_id: b2.id, identity_id: id2.id)
        expect { r.save }.to change { r.building.living_places }.from(2).to(1)
      end
    end
  end

  describe '#enough_living_place' do
    it 'adds error if new residence in the building is not possible' do
      r = described_class.new(building_id: b4.building_id, identity_id: id2.id)
      r.valid? # run validations
      expect(r.errors.messages[:building]).to eq ['building is full!']
    end
  end
end
