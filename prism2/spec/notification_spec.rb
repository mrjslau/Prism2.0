require 'rails_helper.rb'

RSpec.describe Notification, type: :model do
  fixtures :notifications
  let(:notification) { notifications(:one) }

  it 'has a message' do
    expect(notification.message).to eq('Pasilaiciai is on fire')
  end
end
