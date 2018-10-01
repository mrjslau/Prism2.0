# spec/location_spec.rb

require 'spec_helper.rb'

describe Location do
  before(:each) do
    @location = Location.new(54.7, 25.3)
  end
  it 'has a latitude' do
    expect(@location.latitude).to eq 54.7
  end
  it 'has a longitude' do
    expect(@location.longitude).to eq 25.3
  end

  context 'when calculating distance from same point' do
    it 'should return 0' do
      expect(@location.calculate_distance(@location)).to eq 0
    end
  end

  context 'when calculating distance from 54.7N, 25.3W to 54.8N, 25.4W' do
    it 'should return 12839' do
      expect(@location.calculate_distance(Location.new(54.8, 25.4)).round)
        .to eq 12_839
    end
  end
end
