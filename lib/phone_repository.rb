# lib/person_repository.rb

# PhoneRepository class for persistence
class PhoneRepository
  def get
    Phone.new(Person.new, Location.new(0, 0))
  end
end
