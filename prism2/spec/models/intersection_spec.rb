require 'rails_helper.rb'

RSpec.describe Intersection, type: :model do
  fixtures :intersections
  let(:intersection) { intersections(:zalg_kalv) }

  it 'has a name' do
    expect(intersection.name).to eq('Zalgirio-Kalvariju')
  end

  it 'has street count' do
    expect(intersection.street_count).to be(4)
  end
end
