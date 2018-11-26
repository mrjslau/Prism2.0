require 'rails_helper'

RSpec.describe Location, type: :model do
  fixtures :locations
  let(:location)  { locations(:one) }
  let(:location2) { locations(:two) }

  describe '#calculate_distance' do
    context 'when calculating distance from same point' do
      it 'returns 0' do
        expect(location.calculate_distance(location)).to eq 0
      end
    end

    context 'with 2 or more comments' do
      it 'returns 12839' do
        expect(location.calculate_distance(described_class
                                           .new(latitude: 54.8,
                                                longitude: 25.4)))
          .to eq 12_839
      end
    end

    context 'when latitude or longitude and changed by x distance' do
      it 'calculates x meter distance from old location' do
        old_loc = described_class.new(latitude: location2.latitude,
                                      longitude: location2.longitude)
        location2.change_latitude(0.0004)
        location2.change_longitude(0.0002)
        expect(location2.calculate_distance(old_loc)).to eq 50
      end
    end
  end

  describe '#change_latitude' do
    context 'when changing latitude' do
      it 'its not the same as before' do
        expect { location.change_latitude(54.8) }
          .to change(location, :latitude).from(54.7).to(54.8)
      end
    end

    context 'when changing latitude to 54.8' do
      it 'latitude should be equal to 54.8' do
        expect(location.change_latitude(54.8)).to eq(54.8)
      end
    end
  end

  describe '#change_longitude' do
    context 'when changing longitude' do
      it 'its not the same as before' do
        expect { location.change_longitude(25.4) }
          .to change(location, :longitude).from(25.3).to(25.4)
      end
    end

    context 'when changing longitude to 25.4' do
      it 'longitude should be equal to 25.4' do
        expect(location.change_longitude(25.4)).to eq(25.4)
      end
    end
  end

  describe '#to_s' do
    context 'when printing location 54.7, 25.3' do
      it 'will print [54.7, 25.3]' do
        expect(location.to_s).to eq('[54.7, 25.3]')
      end
    end
  end
end
