class RenameTypeToOther < ActiveRecord::Migration[5.1]
  def change
    rename_column :references, :type, :reference_type
  end
end
