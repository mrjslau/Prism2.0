# GateBarrier model class
class GateBarrier < ApplicationRecord
  has_one :location

  def block_way
    self.status = true
  end

  def unblock_way
    self.status = false
  end

  def blocked?
    self.status
  end
end
