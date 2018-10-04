# spec/notification_spec.rb

require 'spec_helper.rb'

describe Notification do
  before(:each) do
    @notification = new.Notification('Hello Prism 2.0')

    it 'After initialization should have message' do
      expect(@notification.message). to eq('Hello Prism 2.0')
    end
  end
end