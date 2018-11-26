require 'rails_helper'

RSpec.describe Ambulance, type: :model do
  fixtures :ambulances, :neighborhoods
  let(:ambulance) { ambulances(:ambulance) }

  describe '#travel_to' do
    context "enters a neighborhood" do
      it "and notifies the neighborhood it entered" do
        neighborhood = mock_model(Neighborhood)
			  expect(neighborhood).to receive(:unit_entered).with(ambulance)
			  ambulance.travel_to(neighborhood)
      end

      it "and notifies the neighborhood it left" do
        old_hood = ambulance.neighborhood
        new_hood = mock_model(Neighborhood)
        allow(new_hood).to receive(:unit_entered) { ambulance }
        ambulance.travel_to(new_hood)
        expect(old_hood.active_objects.fetch(:units)).not_to include(ambulance)
      end
    end
  end
end
