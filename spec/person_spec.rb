# spec/person_spec.rb

require 'spec_helper.rb'

describe Person do
  before(:each) do
    @person = Person.new('Jane', 'Doe', '39700000001', Location.new(0, 0))
  end

  describe 'person has a phone' do
    context 'when person is created' do
      it 'should not have a phone' do
        expect(@person.phone?).to be false
      end
    end
  end
end
