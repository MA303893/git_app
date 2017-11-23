class AddColumnsToQualification < ActiveRecord::Migration[5.1]
  def change
    add_column :qualifications, :name, :string
    add_column :qualifications, :place_of_study, :string
    add_column :qualifications, :country, :string
    add_column :qualifications, :subjects, :string
    add_column :qualifications, :duration, :string
    add_column :qualifications, :date_of_completion, :string
  end
end
