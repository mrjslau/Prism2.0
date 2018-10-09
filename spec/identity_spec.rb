# spec/identity_spec.rb

require 'spec_helper.rb'

describe Identity do
  before(:each) do
    @person = Person.new('John', 'Siva', 'male', '1996-05-25',
                         Location.new(25, 25))
  end

  context 'if there were created a second identity with the same birth date ' do
    it 'should add 1 to the already existing personal_code' do
      identity = Identity.new('Tom', 'Sue', 'male', '1996-05-25')
      expect(identity.personal_code).to eq((@person.identity.personal_code.to_i + 1).to_s)
    end
  end
end
