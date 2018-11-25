class ChangPersonalCodeToBeBigintToIdentities < ActiveRecord::Migration[5.1]
  def change
    change_column :identities, :personal_code, :bigint
  end
end
