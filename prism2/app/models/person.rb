# Person model, it has identity, location, belongings
# and criminal records
class Person < ApplicationRecord
  has_one :identity
  has_one :location
  has_many :phones
  belongs_to :map

  def change_location(location)
    @location = location
  end

  def add_phone(phone)
    phones << phone
  end

  def remove_phones
    phones.clear
  end

  # def status
  #   identity.criminal_status
  # end

  def phones?
    !phones.empty?
  end

  def near_any_phone?
    phones.any?(&:detect_if_owner_is_near)
  end

  def add_pet(pet)
    pets << pet
  end

  def remove_pets
    pets.clear
  end

  def pets?
    !pets.empty?
  end

  def near_any_pet?
    pets.any?(&:detect_if_owner_is_near)
  end
end
