# spec/location_spec.rb

require 'spec_helper.rb'

RSpec::Matchers.define :have_same_location do |expected_object|
  match do |actual_object|
    if actual_object.location.latitude == expected_object.location.latitude
      actual_object.location.longitude == expected_object.location.longitude
    else
      false
    end
  end
end

describe Location do
  let(:location)  { described_class.new(54.7, 25.3) }
  let(:location2) { described_class.new(0, 0)       }

  describe '#calculate_distance' do
    context 'when calculating distance from same point' do
      it 'returns 0' do
        expect(location.calculate_distance(location)).to eq 0
      end
    end

    context 'when calculating distance from 54.7N, 25.3W to 54.8N, 25.4W' do
      it 'returns 12839' do
        expect(location.calculate_distance(described_class.new(54.8, 25.4)))
          .to eq 12_839
      end
    end

    context 'when latitude or longitude and changed by x distance' do
      it 'calculates x meter distance from old location' do
        old_loc = described_class.new(location2.latitude, location2.longitude)
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

  context 'when creating two objects in the same location' do
    it 'their location should be equal' do
      person1 = Person.new('Jane', 'Doe', 'female', '1992-10-12',
                           described_class.new(54, 23))
      person2 = Person.new('John', 'Doe', 'male', '1990-10-12',
                           described_class.new(54, 23))
      expect(person1).to have_same_location(person2)
    end
  end

  context 'when creating two objects in different locations' do
    it 'their location should not be equal' do
      person1 = Person.new('Jane', 'Doe', 'female', '1992-10-12',
                           described_class.new(54, 23))
      person2 = Person.new('John', 'Doe', 'male', '1990-10-12',
                           described_class.new(23, 54))
      expect(person1).not_to have_same_location(person2)
    end
  end
end
