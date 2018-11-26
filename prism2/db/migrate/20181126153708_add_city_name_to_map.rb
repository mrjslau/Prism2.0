class AddCityNameToMap < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :city_name, :string
  end
end
