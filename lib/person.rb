# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_reader :identity, :status, :location, :phones, :pets

  def initialize(name, surname, sex, date_of_birth, location)
    @identity = Identity.new(name, surname, sex, date_of_birth)
    @status = 'Normal'
    @location = location
    @phones = []
    @pets = []
    Map.instance.residents << self
  end

  def change_status(status)
    @status = status
    Map.instance.notify_abnormal_person(self) if status == 'Suspicious'
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
    "#{@identity.name} #{@identity.surname}'s status has changed to: #{@status}!"
  end
end
