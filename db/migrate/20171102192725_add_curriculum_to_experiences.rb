class AddCurriculumToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :curriculum, :text
    add_column :experiences, :name_of_school, :string
    add_column :experiences, :country, :string
    add_column :experiences, :region, :string
    add_column :experiences, :school_level, :string
    add_column :experiences, :position, :string
    add_column :experiences, :subjects_taught, :string
    add_column :experiences, :from, :date
    add_column :experiences, :to, :date
  end
end
