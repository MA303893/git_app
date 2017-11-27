class AddColsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :title, :text
    add_column :jobs, :description, :text
    add_column :jobs, :location, :string
    add_column :jobs, :skills, :text
    add_column :jobs, :about_school, :text
    add_column :jobs, :no_of_opennings, :integer
    add_column :jobs, :active, :boolean, default: false

  end
end
