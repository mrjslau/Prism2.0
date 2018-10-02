# spec/gate_barrier_spec.rb

require 'spec_helper.rb'

describe GateBarrier do
  let(:gate_barrier) { GateBarrier.new([45.45, 10.20], false) }

  describe '#block_way' do
    it 'lets the barrier down' do
      gate_barrier.block_way
      expect(gate_barrier.is_blocked?).to be(true)
    end
  end
end
