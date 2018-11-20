# AddPersonToIdentities migration
class AddPersonToIdentities < ActiveRecord::Migration[5.1]
  def change
    add_reference :identities, :person, foreign_key: true
  end
end
