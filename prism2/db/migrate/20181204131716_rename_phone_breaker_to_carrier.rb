class RenamePhoneBreakerToCarrier < ActiveRecord::Migration[5.1]
  def change
    rename_table :phone_breakers, :carriers
  end
end
