# spec/gate_barrier_spec.rb

require 'spec_helper.rb'

describe GateBarrier do
  let(:gate_barrier) { GateBarrier.new([45.45, 10.20], false) }

  describe '#block_way' do
    it 'lets the barrier down' do
      gate_barrier.block_way
      expect(gate_barrier.blocked?).to be(true)
    end
  end
  describe '#unblock_way' do
    it 'puts the barrier up' do
      gate_barrier.unblock_way
      expect(gate_barrier.blocked?).to be(false)
    end
  end
end
