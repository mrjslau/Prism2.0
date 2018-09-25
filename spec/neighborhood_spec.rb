# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  let(:city)          { City.new('Vilnius')                       }
  let(:neighborhood)  { Neighborhood.new('Baltupiai', city, 'Normal') }

  describe '#input_crimes' do
    it 'changes crime level' do
      neighborhood.input_crimes(15)
      expect(neighborhood.danger).to be('Dangerous')
    end
  end
end
