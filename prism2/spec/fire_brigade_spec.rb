require 'rails_helper'

RSpec.describe FireBrigade, type: :model do
  fixtures :fire_brigades, :neighborhoods
  let(:brigade) { fire_brigades(:brigade) }

  describe '#travel_to' do
    context 'when enters a neighborhood' do
      it 'and notifies the neighborhood it entered' do
        neighborhood = mock_model(Neighborhood)
        allow(neighborhood).to receive(:unit_entered).with(brigade)
        brigade.travel_to(neighborhood)
      end

      it 'and notifies the neighborhood it left' do
        old_hood = brigade.neighborhood
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { brigade }
        brigade.travel_to(new_hood)
        expect(old_hood.active_objects.fetch(:units)).not_to include(brigade)
      end

      it 'and doesn`t notify a neighborhood if wasnt in one' do
        brigade.neighborhood = nil
        hood = mock_model(Neighborhood)
        allow(hood).to receive(:unit_entered) { brigade }
        brigade.travel_to(hood)
        expect(brigade.neighborhood).not_to have_received(:unit_exited)
      end

      it 'and changes the current active neighborhood' do
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { brigade }
        brigade.travel_to(new_hood)
        expect(brigade.neighborhood).to equal(new_hood)
      end
    end
  end
end
