class MakePaperNumberText < ActiveRecord::Migration[5.2]
  def change
    change_column :papers, :paper_number, :string, :default => 0
  end
end
