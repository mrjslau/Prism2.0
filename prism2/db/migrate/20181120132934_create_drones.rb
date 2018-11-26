class CreateDrones < ActiveRecord::Migration[5.1]
  def change
    create_table :drones do |t|
      t.references :map, foreign_key: true
      t.references :neighborhood, foreign_key: true

      t.timestamps
    end
  end
end
