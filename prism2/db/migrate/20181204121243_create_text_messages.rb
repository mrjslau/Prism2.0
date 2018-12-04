class CreateTextMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :text_messages do |t|
      t.text :message_text
      t.references :author, foreign_key: true
      t.references :recipient, foreign_key: true

      t.timestamps
    end
  end
end
