class CreateGateBarriers < ActiveRecord::Migration[5.1]
  def change
    create_table :gate_barriers do |t|
      t.boolean :status

      t.timestamps
    end
  end
end
