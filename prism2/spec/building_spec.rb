require 'rails_helper'

RSpec.describe Building, type: :model do
  fixtures :neighborhoods, :maps, :buildings

  let(:b1) { buildings(:b_one)        }
  let(:b2) { buildings(:b_two)        }
  let(:b3) { buildings(:b_three)      }
  let(:b4) { buildings(:b_four)       }
  let(:n)  { neighborhood(:didlaukis) }

  subject(:building) do
      described_class.new(building_type: buildings(:b_two).building_type,
                          floors: buildings(:b_two).floors,
                          living_places: 1,
                          neighborhood: buildings(:b_two).neighborhood)
  end
  subject(:building2) do
    described_class.new(building_type: buildings(:b_two).building_type,
                            floors: buildings(:b_two).floors,
                            living_places: 1,
                            neighborhood_id: 3)
  end

  describe '#valid_living_places' do
    context 'when living places are added to non residential building' do
      it 'produces error message' do
        b = described_class.new(living_places: 5, floors: 1,
                                        building_type: 'commercial', neighborhood_id: 1)
        b.valid?
        expect(b.errors.messages[:living_places]).to eq ['non residential building cannot have living places']
      end
    end
    context 'when living places are added to residential building' do
      it 'is valid' do
        b = described_class.new(living_places: 5, floors: 1,
                                        building_type: 'residential', neighborhood_id: 1)
        expect(b).to be_valid
      end
    end
    context 'when living places are added to residential building' do
      it 'is valid' do
        b = described_class.new(living_places: 0, floors: 1,
                                        building_type: 'public', neighborhood_id: 1)
         expect(b).to be_valid
      end
    end
  end

  describe '#livable_and_not_full?' do
    context 'when building is residential and available for new residents' do
      it 'returns true' do
        expect(b2.livable_and_not_full?).to be true
      end
      it 'returns true if there is only one place' do
        expect(building.livable_and_not_full?).to be true
      end
    end
    context 'when building is not residential' do
      it 'returns false' do
        expect(b1.livable_and_not_full?).to be false
      end
    end
    context 'when building is residential, but has no living place left' do
      it 'returns false' do
        expect(b4.livable_and_not_full?).to be false
      end
    end
  end

  describe '#init_living_places_if_nil' do
    context 'when new building is added to the table' do
      it 'initializes living places to 0 if it was not initialized' do
        b = described_class.new(living_places: nil, floors: 1,
                                building_type: 'commercial', neighborhood_id: 1)
        expect(b.send(:init_living_places_if_nil)).to eq 0
      end
      it 'initializes living places to 0 if it was not initialized' do
        b = described_class.new(living_places: 5, floors: 1,
                                building_type: 'residential', neighborhood_id: 1)
        expect(b.send(:init_living_places_if_nil)).not_to eq 0
      end
    end

    context 'when validation is performed' do
      it 'initializes living_places to 0' do
        b = described_class.new(living_places: nil, floors: 1,
                                building_type: 'commercial', neighborhood_id: 1)
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

  describe '#map_id' do
    it 'returns maps, in which this building is build, id' do
      expect(b3.map_id).to eq(b3.neighborhood.map.id)
    end
    it 'is not the same as neighborhood id' do
      expect(b3.map_id).not_to eq(b3.neighborhood.id)
    end
  end

  # describe '#last_as_id' do
  #  context 'when id is being generated ' do
  #    it 'fetch last id building of similar category' do
  #      expect(b1.send(:last_as_id,
  #                     7_001_001_000, 7_001_002_000)).to be 7_001_001_001
  #    end
  #  end
  # end

  describe '#generate_building_id' do
    context 'when id is being generated ' do
      it 'produces new unique id' do
        b = described_class.new(living_places: 0, floors: 1,
                                building_type: 'commercial', neighborhood_id: 1)
        expect(b.send(:generate_building_id)). to be 5_001_001_002
      end
      it 'generates id in a 100 range more than' do
        expect(building.send(:generate_building_id)).to be > (((
         building.send(:type_no) * 1000 + building.map_id
       ) * 1000 + building.neighborhood_id) * 1000)
      end
      it 'generates id in a 100 range more than' do
        expect(building.send(:generate_building_id)).to be < (((
         building.send(:type_no) * 1000 + building.map_id
       ) * 1000 + building.neighborhood_id) * 1000 + 1000)
      end
      it 'generates id to the new combination of buildings traits that ends in 1' do
         expect(building2.send(:generate_building_id)).to eq(((
         building2.send(:type_no) * 1000 + building2.map_id
       ) * 1000 + building2.neighborhood.id) * 1000 + 1)
      end

      it 'generates id to building to which similar exists that ends in last id + 1' do
         expect(building.send(:generate_building_id)).to eq(((
         building.send(:type_no) * 1000 + building.map_id
       ) * 1000 + building.neighborhood.id) * 1000 + 3)
      end
      it 's generated id % 10^9 to eq 1001003' do
        expect(building.send(:generate_building_id) % 6000000000).to eq (1001003)
      end
      it 's generated id % 10^6 to eq 1003' do
        expect(building.send(:generate_building_id) % 1000000).to eq (1003)
      end
      it 's generated id % 10^3 to eq 1001003' do
        expect(building.send(:generate_building_id) % 1000).to eq (3)
      end
    end
  end

  describe '#init_building_id' do
    context 'when building is being saved ' do
      it 'saves newly generated id value' do
        b = described_class.new(living_places: 0, floors: 1,
                                building_type: 'commercial', neighborhood_id: 1)
        b.save
        expect(b.building_id).to be 5_001_001_002
      end
    end
  end
end
