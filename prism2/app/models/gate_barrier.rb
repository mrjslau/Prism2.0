# GateBarrier model class
class GateBarrier < ApplicationRecord
  has_one :location

  def block_way
    @status = true
  end

  def unblock_way
    @status = false
  end

  def blocked?
    status
  end
end
