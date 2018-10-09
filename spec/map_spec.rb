# spec/map_spec.rb

require 'spec_helper.rb'

describe Map do
  let(:ambulance)    { Ambulance.new                                      }
  let(:brigade)      { Brigade.new                                        }
  let(:drone)        { Drone.new                                          }
  let(:neighborhood) { Neighborhood.new('Baltupiai', 'Vilnius', 2)        }
  let(:location)     { Location.new(0, 0)                                 }
  let(:person)       { Person.new('Jane', 'Doe', '39700000001', location) }
  let(:police)       { Police.new                                         }
  let(:map)          { described_class.instance                           }

  describe 'user' do
    it 'selects an active neighborhood' do
      map.select_neighborhood(neighborhood)
      expect(map.active_neighborhood).to eql(neighborhood)
    end
  end

  describe 'system' do
    context 'when the active neighborhood`s temperature is abnormal' do
      it 'notifies' do
        notifications_count = map.notifications.length
        map.select_neighborhood(neighborhood)
        neighborhood.change_temperature 67
        expect(map.notifications.length).to eql(notifications_count + 1)
      end
      it 'sends a drone' do
        map.select_neighborhood(neighborhood)
        neighborhood.change_temperature 67
        expect(map.active_neighborhood.active_objects[:units].length).to be(1)
      end
    end

    context 'when a person`s status was changed to suspicious' do
      it 'notifies' do
        notifications_count = map.notifications.length
        neighborhood.person_entered(person)
        map.select_neighborhood(neighborhood)
        person.change_status('Suspicious')
        expect(map.notifications.length).to eql(notifications_count + 1)
      end
    end
  end
end
