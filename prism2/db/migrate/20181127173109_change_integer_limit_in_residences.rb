class ChangeIntegerLimitInResidences < ActiveRecord::Migration[5.1]
  def change
    change_column :residences, :building_id, :integer, limit: 8
    change_column :residences, :identity_id, :integer, limit: 8
  end
end
