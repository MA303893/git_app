class AddColumnsToLicences < ActiveRecord::Migration[5.1]
  def change
    add_column :licences, :name, :string
    add_column :licences, :country, :string
    add_column :licences, :registration_no, :string
  end
end
