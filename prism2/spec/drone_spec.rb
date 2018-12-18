require 'rails_helper'

RSpec.describe Drone, type: :model do
  fixtures :drones, :neighborhoods
  let(:drone) { drones(:drone) }

  describe '#travel_to' do
    context 'when it enters a neighborhood' do
      it 'notifies the neighborhood it entered' do
        neighborhood = mock_model(Neighborhood)
        allow(neighborhood).to receive(:unit_entered).with(drone)
        drone.travel_to(neighborhood)
      end

      it 'notifies the neighborhood it left' do
        old_hood = drone.neighborhood
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { drone }
        drone.travel_to(new_hood)
        expect(old_hood.active_objects.fetch(:units)).not_to include(drone)
      end

      it 'and doesn`t notify a neighborhood if wasnt in one' do
        drone.neighborhood = nil
        hood = mock_model(Neighborhood)
        allow(hood).to receive(:unit_entered) { drone }
        drone.travel_to(hood)
        expect(drone.neighborhood).not_to have_received(:unit_exited)
      end

      it 'and changes the current active neighborhood' do
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { drone }
        drone.travel_to(new_hood)
        expect(drone.neighborhood).to equal(new_hood)
      end
    end
  end
end
