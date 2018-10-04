# spec/gate_barrier_spec.rb

require 'spec_helper.rb'

describe GateBarrier do
  let(:gate_barrier) { GateBarrier.new(45.45, 10.20, false) }

  it 'should have a location of 45.45 latitude and 10.20 longitude' do
    expect(gate_barrier.location.latitude).to eq(45.45)
    expect(gate_barrier.location.longitude).to eq(10.20)
  end

  it 'should be let down and status should be false' do
    expect(gate_barrier.status).to be(false)
    expect(gate_barrier.blocked?).to be(false)
  end

  context 'when gate barrier already up' do
    describe '#unblock way' do
      it 'does not change that' do
        gate_barrier.unblock_way
        expect(gate_barrier.blocked?).to be(false)
      end
    end
  end

  describe '#block_way' do
    it 'lets the barrier down' do
      gate_barrier.block_way
      expect(gate_barrier.blocked?).to be(true)
    end
  end

  context 'when gate barrier is already down' do
    describe '#unblock_way' do
      it 'does not change that' do
        gate_barrier.block_way
        expect(gate_barrier.blocked?).to be(true)
      end
    end
  end

  describe '#unblock_way' do
    it 'puts the barrier up' do
      gate_barrier.unblock_way
      expect(gate_barrier.blocked?).to be(false)
    end
  end
end
