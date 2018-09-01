class UpdateFieldPaperNumberFromTablePapers < ActiveRecord::Migration[5.2]
  def change
    change_column :papers, :paper_number, :string, :default => nil
  end
end
