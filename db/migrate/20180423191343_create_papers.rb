class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :title, null: false, limit: 256
      t.text :abstract, null: true
      t.integer :paper_number, null: false
      t.date :creation_date, null: true
      t.text :keywords, null: true
      t.integer :paper_length, null: true
      t.text :classification_jel, null: true
      t.json :authors, null: false

      t.timestamps
    end
  end
end
