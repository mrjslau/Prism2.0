# CreateIdentities migration
class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities, id: false, primary_key: :personal_code do |t|
      t.integer :personal_code
      t.string :full_name

      t.timestamps
    end
  end
end
