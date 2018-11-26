class AddGateBarrierToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :gate_barrier, foreign_key: true
  end
end
