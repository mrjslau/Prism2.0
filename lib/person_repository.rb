# lib/person_repository.rb

# PersonRepository class is acting as a database
# for the Person entity
# It contains
class PersonRepository
  def get
    Person.new('Jane', 'Doe')
  end
end
