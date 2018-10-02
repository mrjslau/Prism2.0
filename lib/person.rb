# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_reader :name, :surname, :status, :location, :personal_code, :phones,
              :pets

  def initialize(name, surname, personal_code, location)
    @name = name
    @surname = surname
    @status = 'Normal'
    @map = Map.instance
    @personal_code = personal_code
    @location = location
    @phones = []
    @pets = []
  end

  def change_status(status)
    @status = status
    @map.notify_abnormal_person(self) if status == 'Suspicious'
  end

  def change_location(location)
    @location = location
  end

  def add_phone(phone_location)
    @phones << Phone.new(self, phone_location)
  end

  def remove_phones
    @phones = []
  end

  def phones?
    !@phones.empty?
  end

  def near_any_phone?
    @phones.any?(&:detect_if_owner_is_near)
  end

  def add_pet(pet_location)
    @pets << Pet.new(self, pet_location)
  end

  def remove_pets
    @pets = []
  end

  def pets?
    !@pets.empty?
  end

  def status_change_msg
    "#{@name} #{@surname}'s status has changed to: #{@status}!"
  end
end
