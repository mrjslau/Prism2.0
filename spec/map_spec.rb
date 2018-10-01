# spec/map_spec.rb

require 'spec_helper.rb'

describe Map do
  before do
    @ambulance = AmbulanceRepository.new.get
    @brigade = BrigadeRepository.new.get
    @drone = DroneRepository.new.get
    @neighborhood = NeighborhoodRepository.new.get
    @person = PersonRepository.new.get
    @police = PoliceRepository.new.get
    @map = Map.instance
  end

  describe 'user' do
    it 'selects an active neighborhood' do
      @map.active_neighborhood = @neighborhood
      expect(@map.active_neighborhood).to eql(@neighborhood)
    end

    it 'sends police to a neighborhood' do
      @map.send_police(@police, @neighborhood)
      expect(@police.active_neighborhood).to eql(@neighborhood)
      expect(@neighborhood.active_units.length).to eql 1
    end

    it 'sends an ambulance to a neighborhood' do
      @map.send_ambulance(@ambulance, @neighborhood)
      expect(@ambulance.active_neighborhood).to eql(@neighborhood)
      expect(@neighborhood.active_units.length).to eql 1
    end

    it 'sends a fire brigade to a neighborhood' do
      @map.send_brigade(@brigade, @neighborhood)
      active = @brigade.active_neighborhood
      expect(active).to eql(@neighborhood)
      expect(@neighborhood.active_units.length).to eql 1
    end

    it 'sends a drone to a neighborhood' do
      @map.send_drone(@drone, @neighborhood)
      expect(@drone.active_neighborhood).to eql(@neighborhood)
      expect(@neighborhood.active_units.length).to eql 1
    end

    it "observes a neighborhood's temperature" do
      @map.active_neighborhood = @neighborhood
      map_see_temp = @map.neighborhood_temperature
      real_temp = @neighborhood.average_temperature
      expect(map_see_temp).to eql(real_temp)
    end

    it "observes a neighborhood's active emergency response units" do
      @map.active_neighborhood = @neighborhood
      @map.send_police(@police, @neighborhood)
      @map.send_ambulance(@ambulance, @neighborhood)
      @map.send_brigade(@brigade, @neighborhood)

      active_units = @map.active_units
      expect(active_units).to eql([@police, @ambulance, @brigade])
    end
  end

  describe 'system' do
    context 'automatically' do
      it "notifies when the active neighborhood's temperature is abnormal" do
        notifications_count = @map.notifications.length
        @map.active_neighborhood = @neighborhood
        @neighborhood.change_temperature 67
        expect(@map.notifications.length).to eql(notifications_count + 1)
      end
      it "notifies when a person's status was changed to suspicious" do
        notifications_count = @map.notifications.length
        @neighborhood.person_entered(@person)
        @map.active_neighborhood = @neighborhood
        @person.change_status('Suspicious')
        expect(@map.notifications.length).to eql(notifications_count + 1)
      end
      it 'sends a drone to a neighborhood which has an abnormal temperature' do
        @map.active_neighborhood = @neighborhood
        expect(@map.active_units.length).to eql 0
        @neighborhood.change_temperature 67
        expect(@map.active_units.length).to eql 1
      end
    end
  end
end
