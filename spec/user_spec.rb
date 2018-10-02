# spec/user_spec.rb

require 'spec_helper.rb'

describe User do
  let(:user) { User.new('Mantas') }

  it 'should have a name' do
    expect(user.name).to eq('Mantas')
  end
end
