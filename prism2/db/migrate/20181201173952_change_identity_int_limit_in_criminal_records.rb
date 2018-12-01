class ChangeIdentityIntLimitInCriminalRecords < ActiveRecord::Migration[5.1]
  def change
    change_column :criminal_records, :identity_id, :integer, limit: 8
  end
end
