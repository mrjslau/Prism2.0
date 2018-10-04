# lib/gate_barrier.rb

# Gate barrier class...
# it...
class GateBarrier
  attr_reader :location, :status

  def initialize(latitude, longitude, status)
    @location = Location.new(latitude, longitude)
    @status = status
  end

  def block_way
    @status = true
  end

  def unblock_way
    @status = false
  end

  def blocked?
    @status
  end
end
