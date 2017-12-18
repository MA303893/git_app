class AddColsToSchool2 < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :designation, :string
    add_column :schools, :first_name, :string
    add_column :schools, :last_name, :string
    add_column :schools, :middle_name, :string
    add_column :schools, :name, :string
    add_column :schools, :title, :string
  end
end