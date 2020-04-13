class AddRankToAuthorsPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :authors_papers, :rank, :integer
  end
end
