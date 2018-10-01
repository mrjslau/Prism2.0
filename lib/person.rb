# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_accessor :name, :surname, :status, :location, :personal_code, :phones

  def initialize(name, surname, personal_code, location)
    @name = name
    @surname = surname
    @map = Map.instance
    @personal_code = personal_code
    @location = location
  end

  def change_status(status)
    @status = status
    @map.notify_abnormal_person(self) if status == 'Suspicious'
  end

  def add_phone
    @phones << Phone.new(self, Location.new(0, 0))
  end

  def phone?
    false
  end
end
