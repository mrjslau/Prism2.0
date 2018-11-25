require 'rails_helper'

RSpec.describe Location, type: :model do
  fixtures :locations

  context 'with 2 or more comments' do
    it 'returns 12839' do
      expect(locations(:one).calculate_distance(described_class.new(latitude: 54.8, longitude: 25.4)))
        .to eq 12_839
    end
  end
end
