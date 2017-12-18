class AddColsToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :city, :string
    add_column :schools, :country, :string
    add_column :schools, :email, :string
    add_column :schools, :fax, :string
    add_column :schools, :geographic_region, :string
    add_column :schools, :governed_by, :string
    add_column :schools, :phone, :string
    add_column :schools, :postal_code, :string
    add_column :schools, :school_name, :string
    add_column :schools, :state, :string
    add_column :schools, :street_1, :string
    add_column :schools, :street_2, :string
    add_column :schools, :submitted_by, :string
    add_column :schools, :submitted_by_email, :string
    add_column :schools, :website, :string
    add_column :schools, :year_founded, :string
    add_column :schools, :percent_complete, :string
    add_column :schools, :step_no, :integer
    add_column :schools, :new_registration, :boolean
  end
end
