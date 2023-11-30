class RenameAuthorsPapersRank < ActiveRecord::Migration[6.1]
  def change
    rename_column :authors_papers, :rank, :priority
  end
end
