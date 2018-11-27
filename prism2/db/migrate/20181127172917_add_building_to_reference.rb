class AddBuildingToReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :buildings, :building_id, foreign_key: true
  end
end
