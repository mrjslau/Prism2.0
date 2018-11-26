class AddMapToVehicles < ActiveRecord::Migration[5.1]
  def change
    add_reference :vehicles, :map, foreign_key: true
  end
end
