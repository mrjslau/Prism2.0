class CreatePhoneBreakers < ActiveRecord::Migration[5.1]
  def change
    create_table :phone_breakers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
