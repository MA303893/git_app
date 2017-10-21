class AddColumnsToApplicants < ActiveRecord::Migration[5.1]
  def change
    add_column :applicants, :first_name, :string
    add_column :applicants, :last_name, :string
    add_column :applicants, :alt_email, :string

  end
end
