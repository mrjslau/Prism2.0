require 'rails_helper'

RSpec.describe Map, type: :model do
  fixtures :maps, :notifications

  subject(:map) do
    described_class.new(city_name: 'Kaunas')
  end

  let(:notification) { notifications(:one) }

  before do
    map.add_notification(notification)
  end

  describe '#delete_all_notifications' do
    it 'deletes all notifications' do
      map.delete_all_notifications
      expect(map.notifications).to be_empty
    end
  end
end
