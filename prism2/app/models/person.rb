# Person model, it has identity, location, belongings
# and criminal records
class Person < ApplicationRecord
  has_one :identity
  has_one :location

  def change_location(location)
    @location = location
  end
end
