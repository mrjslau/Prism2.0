class CreateTrafficLights < ActiveRecord::Migration[5.1]
  def change
    create_table :traffic_lights do |t|
      t.references :intersection, foreign_key: true
      t.string :signal
      t.boolean :blinking

      t.timestamps
    end
  end
end
