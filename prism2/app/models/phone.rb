# Phone model. Belongs to person,
# can be turned on/off and (dis)connected
class Phone < ApplicationRecord
  belongs_to :person
  has_one :location
  has_one :carrier
  has_many :text_messages
  serialize :messages

  def turn_on
    self.turned_on = true
  end

  def turn_off
    self.turned_on = false
  end

  def connect
    self.connected = turned_on
  end

  def listen_call
    connected && on_call || carrier.establish_connection
  end

  def read_messages
    connected
  end

  def change_location(latitude, longitude)
    location.change_latitude(latitude)
    location.change_longitude(longitude)
  end

  def detect_if_owner_is_near
    location.calculate_distance(person.location) <= 50
  end
end
