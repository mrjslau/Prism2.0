# spec/user_spec.rb

require 'spec_helper.rb'

describe User do
  let(:user) { described_class.new('Mantas') }

  it 'has a name' do
    expect(user.name).to eq('Mantas')
  end
end
