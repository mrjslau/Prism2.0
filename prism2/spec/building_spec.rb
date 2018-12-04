require 'rails_helper'

RSpec.describe Building, type: :model do
  fixtures :neighborhoods, :maps, :buildings, :identities

  subject(:building) do
    described_class.new(building_type: buildings(:b_two).building_type,
                        floors: buildings(:b_two).floors,
                        living_places: 1,
                        neighborhood: buildings(:b_two).neighborhood)
  end

  let(:mock_building) { mock_model(Building) }
  let(:b3) { buildings(:b_three) }
  let(:i2) { identities(:two)    }

  describe '#valid_living_places' do
    context 'when living places are added to the building' do
      it 'produces error message if building is non residential' do
        building.building_type = 'commercial'
        expect { building.valid? }
          .to change { building.errors.messages[:living_places] }
          .from([]).to(['non residential building cannot have living places'])
      end
      it 'is valid if building is residential' do
        expect(building).to be_valid
      end
    end

    context 'when no living places are added to the building' do
      it 'is valid  if it is residential' do
        building.living_places = nil
        expect(building).to be_valid
      end
      it 'is valid if it is commercial' do
        building.living_places = nil
        building.building_type = 'commercial'
        expect(building).to be_valid
      end
    end
  end

  describe '#livable_and_not_full?' do
    context 'when building is residential and available for new residents' do
      it 's livable and not full is called in a new residence creation process' do
        r = Residence.new(building: mock_building, identity: i2)
        expect(mock_building).to receive(:livable_and_not_full?)
        r.valid?
      end
      it 'returns true' do
        expect(building.livable_and_not_full?).to be true
      end
    end

    context 'when building is residential, but has no living place left' do
      it 'returns false' do
        building.living_places = 0
        expect(building.livable_and_not_full?).to be false
      end
    end

    context 'when living_places = nil' do
      it 'returns false' do
        building.living_places = nil
        expect(building.livable_and_not_full?).to be false
      end
    end
  end

  describe '#enough_space_in_neighborhood' do
    context 'when building is added to the neighborhood' do
      it 'produces an error message if neighborhood is full' do
        building.neighborhood_id = 99
        expect { building.valid? }
          .to change { building.errors.messages[:neighborhood] }
          .from([]).to(['neighborhood is full!'])
      end
      it 'produces no error message if neighborhood is not full' do
        building.neighborhood_id = 98
        building.valid?
        expect(building.errors.messages[:neighborhood]).to be_empty
      end
    end
  end

  describe '#init_living_places_if_nil' do
    context 'when new building is added to the table' do
      it 'initializes living places to 0 if it was not initialized' do
        building.living_places = nil
        expect(building.send(:init_living_places_if_nil)).to eq 0
      end
      it 'living_places becomes 0 after validation if its not initialized' do
        building.living_places = nil
        expect { building.valid? }
          .to change(building, :living_places).from(nil).to(0)
      end
      it 'does not initialize living places to 0 if it was not initialized' do
        building.living_places = 5
        expect(building.send(:init_living_places_if_nil)).not_to eq 0
      end
    end
  end

  describe '#type_no' do
    context 'when building_type == commercial' do
      it 'returns 5' do
        building.living_places = 0
        building.building_type = 'commercial'
        expect(building.send(:type_no)).to be 5
      end
    end

    context 'when building_type == residential' do
      it 'returns 6' do
        building.building_type = 'residential'
        expect(building.send(:type_no)).to be 6
      end
    end

    context 'when building_type == public' do
      it 'returns 7' do
        building.living_places = 0
        building.building_type = 'public'
        expect(building.send(:type_no)).to be 7
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

  describe '#generate_building_id' do
    context 'when id is being generated' do
      it 'produces new unique id' do
        building.living_places = 0
        building.building_type = 'commercial'
        expect(building.send(:generate_building_id)).to be 5_001_001_002
      end
      it 'generates id in 1' do
        expect(building.send(:generate_building_id)).to be >= (((
         building.send(:type_no) * 1000 + building.map_id
       ) * 1000 + building.neighborhood_id) * 1000 + 1)
      end
      it 'generates id that ends in 999' do
        expect(building.send(:generate_building_id)).to be <= (((
         building.send(:type_no) * 1000 + building.map_id
       ) * 1000 + building.neighborhood_id) * 1000 + 999)
      end
      it 'generates id to the new building in neighbourhood that ends in 1' do
        building.neighborhood_id = 3
        expect(building.send(:generate_building_id)).to eq(((
        building.send(:type_no) * 1000 + building.map_id
      ) * 1000 + building.neighborhood.id) * 1000 + 1)
      end

      it 'generates id to building in neighborhood that ends in last id + 1' do
        expect(building.send(:generate_building_id)).to eq(((
        building.send(:type_no) * 1000 + building.map_id
      ) * 1000 + building.neighborhood.id) * 1000 + 3)
      end
      it 's generated id % 10^9 to eq 1001003' do
        expect(building.send(:generate_building_id) % 1_000_000_000)
          .to eq 1_001_003
      end
      it 's generated id % 10^6 to eq 1003' do
        expect(building.send(:generate_building_id) % 1_000_000).to eq 1003
      end
      it 's generated id % 10^3 to eq 1001003' do
        expect(building.send(:generate_building_id) % 1000).to eq 3
      end
    end
  end

  describe '#init_building_id' do
    context 'when building is being saved ' do
      it 'saves newly generated id value' do
        b = described_class.new(living_places: 0, floors: 1,
                                building_type: 'commercial', neighborhood_id: 1)
        expect { b.save } .to change { b.building_id } .from(nil)
                                                       .to(5_001_001_002)
      end
    end
  end
end
