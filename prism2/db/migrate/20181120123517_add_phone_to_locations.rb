class AddPhoneToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :phone, foreign_key: true
  end
end
