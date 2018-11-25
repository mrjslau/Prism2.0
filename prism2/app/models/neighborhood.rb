# Neighborhood model class
class Neighborhood < ApplicationRecord
  has_many :ambulances
  has_many :fire_brigades
  has_many :drones
  has_many :police_units
  belongs_to :map

  def change_temperature(temperature)
    self.temperature = temperature
    notify_abnormal_temperature if temp_abnormal?
  end

  def temp_abnormal?
    temperature > 30
  end

  def notify_abnormal_temperature
    message = "Temperature have reached: #{temperature} in " \
              "#{name} neighborhood!"
    map.add_notification(Notification.create(message: message, map_id: self.map.id))
  end
end
