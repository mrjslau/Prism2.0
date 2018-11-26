class AddActiveObjectsToNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :active_objects, :text
  end
end
