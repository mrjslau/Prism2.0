class CreatePoliceStations < ActiveRecord::Migration[5.1]
  def change
    create_table :police_stations do |t|
      t.references :map, foreign_key: true

      t.timestamps
    end
  end
end
