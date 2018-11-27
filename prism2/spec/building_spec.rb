require 'rails_helper'

RSpec.describe Building, type: :model do
  fixtures :neighborhoods, :maps, :buildings

  let(:b1) { buildings(:b_one) }
  let(:b2) { buildings(:b_two) }
  let(:b3) { buildings(:b_three) }
  let(:n) { neighborhood(:didlaukis) }

  describe '#livable_and_not_full?' do
    context 'when building is residential and available for new residents' do
       it 'returns true' do
        expect(b2.livable_and_not_full?).to be true
       end
    end
    context 'when building is not residential' do
      it 'returns false' do
       expect(b1.livable_and_not_full?).to be false
      end
    end
  end

  describe '#init_living_places_if_nil' do
    context 'when new building is added to the table and living_places is nil' do
      it 'initializes living places to nil if it was not initialized' do
        p = nil;
        b = described_class.new(living_places: p, floors:1, building_type:'commercial', neighborhood_id:1)
        expect(b.living_places).to be nil
      end
     end
     context 'when validation is performed' do
      it 'initializes living_places to 0' do
        p = nil;
        b = described_class.new(living_places: p, floors:1, building_type:'commercial', neighborhood_id:1)
        b.valid?
        expect(b.living_places).to be 0
     end
    end
  end

  describe '#type_no' do
    context 'when building_type == commercial' do
      it 'returns 5' do
        expect(b1.send(:type_no)).to be 5
      end
    end
    context 'when building_type == residential' do
      it 'returns 6' do
        expect(b2.send(:type_no)).to be 6
      end
    end
    context 'when building_type == public' do
      it 'returns 7' do
        expect(b3.send(:type_no)).to be 7
      end
    end
  end

  describe '#last_as_id' do
    context 'when id is being generated ' do
      it 'fetch last id building of similar category' do
       expect(b1.send(:last_as_id, 7001001000, 7001002000)).to be 7001001001
      end
    end
  end

  describe '#generate_building_id' do
    context 'when id is being generated ' do
      it 'produces new unique id' do
        b = described_class.new(living_places: 0, floors:1, building_type:'commercial', neighborhood_id:1)
        expect(b.send(:generate_building_id)). to be 5001001002
      end
    end
  end

  describe '#init_building_id' do
    context 'when building is being saved ' do
      it 'saves newly generated id value' do
        b = described_class.new(living_places: 0, floors:1, building_type:'commercial', neighborhood_id:1)
        b.save
        expect(b.building_id).to be 5001001002
      end
    end
  end


end