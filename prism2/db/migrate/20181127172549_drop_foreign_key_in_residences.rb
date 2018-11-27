class DropForeignKeyInResidences < ActiveRecord::Migration[5.1]
  def change
    remove_reference :residences, :building_id, index: true, foreign_key: true
  end
end
