# spec/map_spec.rb

require 'spec_helper.rb'

describe Map do
  before do
    @ambulance = Ambulance.new
    @brigade = Brigade.new
    @drone = Drone.new
    @neighbourhood = Neighborhood.new('Baltupiai', 'Vilnius', 2)
    @person = Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0))
    @police = Police.new
    @map = Map.instance
    @city = City.new('Vilnius')
  end

  describe 'user' do
    it 'selects an active neighbourhood' do
      @map.select_neighborhood(@neighbourhood)
      expect(@map.active_neighborhood).to eql(@neighbourhood)
    end

    it 'sends police to a neighbourhood' do
      @map.send_police(@police, @neighbourhood)
      expect(@police.active_neighborhood).to eql(@neighbourhood)
      expect(@neighbourhood.active_units.length).to eql 1
    end

    it 'sends an ambulance to a neighbourhood' do
      @map.send_ambulance(@ambulance, @neighbourhood)
      expect(@ambulance.active_neighborhood).to eql(@neighbourhood)
      expect(@neighbourhood.active_units.length).to eql 1
    end

    it 'sends a fire brigade to a neighbourhood' do
      @map.send_brigade(@brigade, @neighbourhood)
      active = @brigade.active_neighborhood
      expect(active).to eql(@neighbourhood)
      expect(@neighbourhood.active_units.length).to eql 1
    end

    it 'sends a drone to a neighbourhood' do
      @map.send_drone(@drone, @neighbourhood)
      expect(@drone.active_neighborhood).to eql(@neighbourhood)
      expect(@neighbourhood.active_units.length).to eql 1
    end

    it "observes a neighbourhood's temperature" do
      @map.select_neighborhood(@neighbourhood)
      map_see_temp = @map.neighborhood_temperature
      real_temp = @neighbourhood.cur_temperature || @neighbourhood.avg_temperature
      expect(map_see_temp).to eql(real_temp)
    end

    it "observes a neighbourhood's active emergency response units" do
      @map.select_neighborhood(@neighbourhood)
      @map.send_police(@police, @neighbourhood)
      @map.send_ambulance(@ambulance, @neighbourhood)
      @map.send_brigade(@brigade, @neighbourhood)

      active_units = @map.active_units
      expect(active_units).to eql([@police, @ambulance, @brigade])
    end
  end

  describe 'system' do
    context 'automatically' do
      it "notifies when the active neighborhood's temperature is abnormal" do
        notifications_count = @map.notifications.length
        @map.select_neighborhood(@neighbourhood)
        @neighbourhood.change_temperature 67
        expect(@map.notifications.length).to eql(notifications_count + 1)
      end
      it "notifies when a person's status was changed to suspicious" do
        notifications_count = @map.notifications.length
        @neighbourhood.person_entered(@person)
        @map.select_neighborhood(@neighbourhood)
        @person.change_status('Suspicious')
        expect(@map.notifications.length).to eql(notifications_count + 1)
      end
      it 'sends a drone to a neighbourhood which has an abnormal temperature' do
        @map.select_neighborhood(@neighbourhood)
        expect(@map.active_units.length).to eql 0
        @neighbourhood.change_temperature 67
        expect(@map.active_units.length).to eql 1
      end
    end
  end
end
