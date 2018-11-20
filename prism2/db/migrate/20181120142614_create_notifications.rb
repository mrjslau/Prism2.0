class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :message
      t.references :map, foreign_key: true

      t.timestamps
    end
  end
end
