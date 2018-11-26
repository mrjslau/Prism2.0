## lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_reader :identity, :location, :belongings

  def initialize(name, surname, sex, date_of_birth, location)
    @identity = Identity.new(name, surname, sex, date_of_birth)
    @location = location
    @belongings = { phones: [], pets: [] }
    Map.instance.residents << self
  end

  def change_location(location)
    @location = location
  end

  def add_phone(phone_location)
    belongings.fetch(:phones) << Phone.new(self, phone_location)
  end

  def remove_phones
    belongings.fetch(:phones).clear
  end

  def status
    identity.criminal_status
  end

  def phones?
    !belongings.fetch(:phones).empty?
  end

  def near_any_phone?
    belongings.fetch(:phones).any?(&:detect_if_owner_is_near)
  end

  def add_pet(pet_location)
    belongings.fetch(:pets) << Pet.new(self, pet_location)
  end

  def remove_pets
    belongings.fetch(:pets).clear
  end

  def pets?
    !belongings.fetch(:pets).empty?
  end
end
