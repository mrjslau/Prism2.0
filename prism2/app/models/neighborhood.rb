# Neighborhood model class
class Neighborhood < ApplicationRecord
  serialize :active_objects
  has_many :ambulances
  has_many :fire_brigades
  has_many :drones
  has_many :police_units
  has_many :criminal_records
  has_many :buildings
  belongs_to :map
  validates :name, presence: true, uniqueness: { scope: :map }
  validates :map, presence: true
  before_validation :init_active_objects_if_nil

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
    map.add_notification(Notification.create(message: message, map_id: map.id))
  end

  def unit_entered(unit)
    active_objects.fetch(:units) << unit
  end

  def unit_exited(unit)
    active_objects.fetch(:units).delete(unit)
  end

  private

  def init_active_objects_if_nil
    self.active_objects = { units: [], people: [] } unless active_objects
  end
end
