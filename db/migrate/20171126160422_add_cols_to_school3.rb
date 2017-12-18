class AddColsToSchool3 < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :details_updated, :boolean, :default => false
    change_column_default :schools, :step_no, 1
  end
end
