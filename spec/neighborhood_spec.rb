# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  let(:city)          { City.new('Vilnius')                              }
  let(:neighborhood)  { described_class.new('Baltupiai', city, 'Normal') }

  describe '#input_crimes' do
    it 'changes crime level to dangerous' do
      neighborhood.input_crimes(15)
      expect(neighborhood.danger).to eq('Dangerous')
    end
    it 'changes crime level to safe' do
      neighborhood.input_crimes(1)
      expect(neighborhood.danger).to eq('Safe')
    end
    it 'changes crime level to normal' do
      neighborhood.input_crimes(3)
      expect(neighborhood.danger).to eq('Normal')
    end
  end
end
