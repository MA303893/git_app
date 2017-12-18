class AddCloumnsToApplicant2 < ActiveRecord::Migration[5.1]
  def change
    add_column :applicants, :title, :string
    add_column :applicants, :middle_name, :string
    add_column :applicants, :website, :string
    add_column :applicants, :skype_name, :string
    add_column :applicants, :alias_name, :string
  end
end
