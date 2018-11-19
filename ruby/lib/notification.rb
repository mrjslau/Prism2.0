# lib/notification.rb

# Notification class represents a message to the user
# it contains...
class Notification
  attr_reader :message

  def initialize(message)
    @message = message
  end
end
