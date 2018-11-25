class AddIdentityNeighborhoodAndOffenseLevelToCriminalRecords < ActiveRecord::Migration[5.1]
  def change
    add_reference :criminal_records, :identity, foreign_key: true
    add_reference :criminal_records, :neighborhood, foreign_key: true
    add_column :criminal_records, :offence_level, :integer
  end
end
