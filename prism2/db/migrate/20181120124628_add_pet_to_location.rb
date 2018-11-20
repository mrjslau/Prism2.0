class AddPetToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :pet, foreign_key: true
  end
end
