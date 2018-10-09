# spec/neighborhood_spec.rb

require 'spec_helper.rb'

describe Neighborhood do
  let(:city)         { City.new('Vilnius')                       }
  let(:neighborhood) { described_class.new('Baltupiai', city, 2) }
  let(:police)       { Police.new(neighborhood)                  }
  let(:ambulance)    { Ambulance.new(neighborhood)               }
  let(:brigade)      { Brigade.new(neighborhood)                 }
  let(:drone)        { Drone.new(neighborhood)                   }

  describe '#input_crimes' do
    it 'changes crime level to dangerous' do
      neighborhood.input_crimes(15)
      expect(neighborhood.status[:danger]).to be(17)
    end
    it 'changes crime level to safe' do
      neighborhood.input_crimes(1)
      expect(neighborhood.status[:danger]).to be(3)
    end
    it 'changes crime level to normal' do
      neighborhood.input_crimes(3)
      expect(neighborhood.status[:danger]).to be(5)
    end
  end

  describe '#send_police' do
    it 'sends police to a neighborhood' do
      neighborhood.send_police(police)
      expect(neighborhood.active_objects[:units].length).to be(1)
    end
  end

  describe '#send_ambulance' do
    it 'sends an ambulance to a neighborhood' do
      neighborhood.send_ambulance(ambulance)
      expect(neighborhood.active_objects[:units].length).to be(1)
    end
  end

  describe '#send_brigade' do
    it 'sends a fire brigade to a neighborhood' do
      neighborhood.send_brigade(brigade)
      expect(neighborhood.active_objects[:units].length).to be(1)
    end
  end

  describe '#send_drone' do
    it 'sends a drone to a neighborhood' do
      neighborhood.send_drone(drone)
      expect(neighborhood.active_objects[:units].length).to be(1)
    end
  end
end
