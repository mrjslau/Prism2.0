class AddOnCallToPhones < ActiveRecord::Migration[5.1]
  def change
    add_column :phones, :on_call, :boolean
  end
end
