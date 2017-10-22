class AddActiveToSchools < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :active, :boolean, null: false, default: false
  end
end