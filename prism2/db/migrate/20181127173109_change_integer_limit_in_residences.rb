class ChangeIntegerLimitInResidences < ActiveRecord::Migration[5.1]
  def change
    change_column :residences, :building_id, :integer, limit: 10
  end
end
