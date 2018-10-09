# spec/police_spec.rb

require 'spec_helper.rb'

describe Police do
  before(:each) do
    @city = City.new('Vilnius')
    @city.add_neighborhood(Neighborhood.new('Tarande', 'Vilnius'))
    @neighbourhood = @city.neighborhoods.last
  end

  context 'what dangerous_neighbourhood? does when it is not dangerous' do
    it 'should return false' do
      expect(@city.emergency_services.fetch(2).dangerous_neighbourhood?(@neighbourhood)).to be(false)
    end
  end
end
