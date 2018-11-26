class AddVehicleToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :vehicle, foreign_key: true
  end
end
