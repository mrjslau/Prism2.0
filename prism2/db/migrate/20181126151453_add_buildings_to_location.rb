class AddBuildingsToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :building, foreign_key: true
  end
end
