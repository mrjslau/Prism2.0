class AddMessagesToPhones < ActiveRecord::Migration[5.1]
  def change
    add_column :phones, :messages, :text
  end
end
