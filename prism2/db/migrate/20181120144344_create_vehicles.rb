class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :licence_number
      t.references :owner, foreign_key: true
      t.references :driver, foreign_key: true

      t.timestamps
    end
  end
end
