# spec/location_spec.rb

require 'spec_helper.rb'

describe Location do
  let(:location) { described_class.new(54.7, 25.3) }

  it 'has a latitude' do
    expect(location.latitude).to eq 54.7
  end
  it 'has a longitude' do
    expect(location.longitude).to eq 25.3
  end

  context 'when calculating distance from same point' do
    it 'returns 0' do
      expect(location.calculate_distance(location)).to eq 0
    end
  end

  context 'when calculating distance from 54.7N, 25.3W to 54.8N, 25.4W' do
    it 'returns 12839' do
      expect(location.calculate_distance(described_class.new(54.8, 25.4)).round)
        .to eq 12_839
    end
  end

  context 'when changing latitude' do
    it 'its not the same as before' do
      old_latitude = location.latitude
      location.change_latitude(54.8)
      expect(old_latitude).not_to eq(location.latitude)
    end
  end

  context 'when changing longitude' do
    it 'its not the same as before' do
      old_longitude = location.longitude
      location.change_longitude(54.8)
      expect(old_longitude).not_to eq(location.longitude)
    end
  end

  context 'when changing latitude to 54.8' do
    it 'latitude should be equal to 54.8' do
      expect(location.change_latitude(54.8)).to eq(54.8)
    end
  end

  context 'when changing longitude to 25.4' do
    it 'longitude should be equal to 25.4' do
      expect(location.change_longitude(25.4)).to eq(25.4)
    end
  end

  context 'when printing location 54.7, 25.3' do
    it 'will print [54.7, 25.3]' do
      expect(location.to_s).to eq('[54.7, 25.3]')
    end
  end
end
