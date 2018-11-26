class AddPersonToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :person, foreign_key: true
  end
end
