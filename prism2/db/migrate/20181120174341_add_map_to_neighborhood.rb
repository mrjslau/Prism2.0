class AddMapToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_reference :neighborhoods, :map, foreign_key: true
  end
end
