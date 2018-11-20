# Vehicle model class
class Vehicle < ApplicationRecord
  belongs_to :owner, class_name: 'Person'
  belongs_to :driver, class_name: 'Person'
  belongs_to :map
  has_one :location

  def drive_to(location)
    self.location = location
  end

  def check_if_owner_is_driving
    location.to_s.eql?(owner.location.to_s)
  end
end
