class AddDateAndGenderToIdentities < ActiveRecord::Migration[5.1]
  def change
    add_column :identities, :gender, :string
    add_column :identities, :birthday, :date
  end
end
