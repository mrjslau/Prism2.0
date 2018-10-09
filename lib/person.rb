# lib/person.rb

# Person class represents a trackable person in a city
# It contains
class Person
  attr_reader :personal_information, :details, :belongings
  def initialize(name, surname, personal_code, location)
    @personal_information = { name: name, surname: surname,
                              personal_code: personal_code }
    @details = { status: 'Normal', location: location }
    @belongings = { phones: [], pets: [] }
    @map = Map.instance
  end

  def change_status(status)
    @details[:status] = status
    @map.notify_abnormal_person(self) if status == 'Suspicious'
  end

  def change_location(location)
    @details[:location] = location
  end

  def add_phone(phone_location)
    @belongings[:phones] << Phone.new(self, phone_location)
  end

  def remove_phones
    @belongings[:phones] = []
  end

  def phones?
    !@belongings[:phones].empty?
  end

  def near_any_phone?
    @belongings[:phones].any?(&:detect_if_owner_is_near)
  end

  def add_pet(pet_location)
    @belongings[:pets] << Pet.new(self, pet_location)
  end

  def remove_pets
    @belongings[:pets] = []
  end

  def pets?
    !@belongings[:pets].empty?
  end

  def status_change_msg
    "#{@personal_information[:name]} #{@personal_information[:surname]}'s\s
     status has changed to: #{@details[:status]}!"
  end
end
