class RemoveUserFromPhoneBreakersAndAddPhoneToPhoneBreakers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :carriers, :user, foreign_key: true
    add_reference :carriers, :phone, foreign_key: true
  end
end
