class AddMapToPeople < ActiveRecord::Migration[5.1]
  def change
    add_reference :people, :map, foreign_key: true
  end
end
