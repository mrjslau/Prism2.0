# spec/intersection_spec.rb

require 'spec_helper.rb'

describe Intersection do
  let(:intersection) { Intersection.new('Zalgirio-Kalvariju', 4) }

  it 'should have a name and street count' do
    expect(intersection.name).to eq('Zalgirio-Kalvariju')
    expect(intersection.street_count).to be(4)
  end
end
