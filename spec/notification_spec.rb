# spec/notification_spec.rb

require 'spec_helper.rb'

describe Notification do
  before(:each) do
    @notification = Notification.new('Hello Prism 2.0')
  end
  it 'After initialization message' do
    expect(@notification.message). to eq('Hello Prism 2.0')
  end
end
