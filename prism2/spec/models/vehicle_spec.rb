require 'rails_helper.rb'

RSpec.describe Vehicle, type: :model do
  fixtures :vehicles, :locations
  let(:location1) { locations(:one)                        }
  let(:location2) { locations(:two)                        }
  let(:person1)   { Person.new(id: 1, location: location1) }
  let(:person2)   { Person.new(id: 2, location: location2) }
  let(:vehicle)   { vehicles(:bmw)                         }
  let(:vehicle2)  { vehicles(:porsche)                     }

  before do
    vehicle.owner = person1
    vehicle.driver = person2
    vehicle.location = location1
    vehicle2.owner = person2
    vehicle2.driver = person2
    vehicle2.location = location2
  end

  describe '#drive_to' do
    context 'when moving' do
      it 'changes location' do
        vehicle.drive_to(location2)
        expect(vehicle.location.to_s).not_to eq '[54.7, 25.3]'
      end
      it 's new location is the location it drove to' do
        vehicle.drive_to(location1)
        expect(vehicle.location).to eq(location1)
      end
    end
  end

  describe '#check_if_owner_is_driving' do
    context 'when owner is driving' do
      it 'confirms that owner is in the car' do
        expect(vehicle2.check_if_owner_is_driving).to be true
      end
    end

    context 'when owner is not driving' do
      it 'confirms that owner is not in the car' do
        vehicle.owner.change_location(location2)
        expect(vehicle.check_if_owner_is_driving).to be false
      end
    end
  end
end
