class CreateJoinTablePapersAuthors < ActiveRecord::Migration[5.2]
  def change
    create_join_table :papers, :authors do |t|
       t.index [:paper_id, :author_id]
    end
  end
end
