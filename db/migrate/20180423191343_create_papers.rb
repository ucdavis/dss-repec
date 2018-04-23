class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :Author
      t.string :Title

      t.timestamps
    end
  end
end
