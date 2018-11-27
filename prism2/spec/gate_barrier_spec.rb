require 'rails_helper.rb'

RSpec.describe GateBarrier, type: :model do
  fixtures :gate_barriers
  let(:gate_barrier) { gate_barriers(:one) }

  it 'has a false status by default' do
    expect(gate_barrier.status).to eq(false)
  end

  describe '#block_way' do
    it 'blocks the barrier' do
      gate_barrier.block_way
      expect(gate_barrier.status).to eq(true)
    end
  end

  describe '#unblock_way' do
    it 'unblocks the barrier' do
      gate_barrier.unblock_way
      expect(gate_barrier.status).to eq(false)
    end
  end

  describe '#blocked?' do
    it 'returns true if it is blocked' do
      gate_barrier.block_way
      expect(gate_barrier.blocked?).to eq(true)
    end
    it 'returns false if it is not blocked' do
      expect(gate_barrier.blocked?).to eq(false)
    end
  end
end
