class ChangeIntegerLimitInBuildings < ActiveRecord::Migration[5.1]
  def change
    change_column :buildings, :building_id, :integer, limit: 10
  end
end