# CreateIdentities migration
class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.integer :personal_code, limit: 8
      t.string :full_name

      t.timestamps
    end
  end
end
