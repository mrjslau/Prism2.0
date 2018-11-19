# spec/intersection_spec.rb

require 'spec_helper.rb'

describe Intersection do
  let(:intersection) { described_class.new('Zalgirio-Kalvariju', 4) }

  it 'has a name' do
    expect(intersection.name).to eq('Zalgirio-Kalvariju')
  end

  it 'has street count' do
    expect(intersection.street_count).to be(4)
  end
end
