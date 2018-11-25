class CreateCriminalRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :criminal_records do |t|
      t.references :police_station, foreign_key: true

      t.timestamps
    end
  end
end
