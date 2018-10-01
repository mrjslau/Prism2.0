# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_accessor :name, :surname, :status, :location

  def initialize(name, surname, location)
    @name = name
    @surname = surname
    @map = Map.instance
    @location = location
  end

  def change_status(status)
    @status = status
    @map.notify_abnormal_person(self) if status == 'Suspicious'
  end
end
