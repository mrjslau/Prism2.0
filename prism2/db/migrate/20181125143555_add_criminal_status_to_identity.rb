class AddCriminalStatusToIdentity < ActiveRecord::Migration[5.1]
  def change
    add_column :identities, :criminal_status, :integer
  end
end
