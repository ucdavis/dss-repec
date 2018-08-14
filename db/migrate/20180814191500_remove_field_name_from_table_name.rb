class RemoveFieldNameFromTableName < ActiveRecord::Migration[5.2]
  def change
    remove_column :papers, :authors, :text
  end
end
