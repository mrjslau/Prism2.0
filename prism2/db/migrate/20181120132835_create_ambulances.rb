class CreateAmbulances < ActiveRecord::Migration[5.1]
  def change
    create_table :ambulances do |t|
      t.references :map, foreign_key: true
      t.references :neighborhood, foreign_key: true

      t.timestamps
    end
  end
end
