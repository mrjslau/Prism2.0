class CreateResidences < ActiveRecord::Migration[5.1]
  def change
    create_table :residences do |t|
      t.references :identity, foreign_key: true
      t.references :building, foreign_key: true

      t.timestamps
    end
  end
end
