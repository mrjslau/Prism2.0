# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_accessor :name, :surname, :status

  def initialize(name = 'John', surname = 'Doe')
    @name = name
    @surname = surname
    @map = Map.instance
  end

  def change_status(status)
    @status = status
    @map.notify_abnormal_person(self) if status == 'Suspicious'
  end
end
