require 'rails_helper'

RSpec.describe PoliceUnit, type: :model do
  fixtures :police_units, :neighborhoods
  let(:unit) { police_units(:unit) }

  describe '#travel_to' do
    context 'when police unit enters a neighborhood' do
      it 'and notifies the neighborhood it entered' do
        neighborhood = mock_model(Neighborhood)
        allow(neighborhood).to receive(:unit_entered).and_return(unit)
        unit.travel_to(neighborhood)
      end

      it 'and notifies the neighborhood it left' do
        old_hood = unit.neighborhood
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { unit }
        unit.travel_to(new_hood)
        expect(old_hood.active_objects.fetch(:units)).not_to include(unit)
      end

      it "and doesn't notify a neighborhood if wasnt in one" do
        unit.neighborhood = nil
        hood = mock_model(Neighborhood)
        allow(hood).to receive(:unit_entered) { unit }
        unit.travel_to(hood)
        expect(unit.neighborhood).not_to have_received(:unit_exited)
      end

      it 'and changes the current active neighborhood' do
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { unit }
        unit.travel_to(new_hood)
        expect(unit.neighborhood).to equal(new_hood)
      end
    end
  end
end
