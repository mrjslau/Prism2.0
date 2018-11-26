class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings, id: false, primary_key: :building_id do |t|
      t.bigint :building_id
      t.string :building_type
      t.integer :floors
      t.integer :living_places
      t.references :neighborhood, foreign_key: true

      t.timestamps
    end
  end
end