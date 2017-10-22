class AddColumnsToApplicants < ActiveRecord::Migration[5.1]
  def change
    add_column :applicants, :first_name, :string
    add_column :applicants, :last_name, :string
    add_column :applicants, :alt_email, :string
    add_column :applicants, :country_of_citizenship, :string
    add_column :applicants, :other_citizenship, :boolean
    add_column :applicants, :other_citizenship_country, :string
    add_column :applicants, :eu_passport, :boolean
    add_column :applicants, :country_of_birth, :string
    add_column :applicants, :gender, :string
    add_column :applicants, :marital_status, :string
    add_column :applicants, :dob, :date
    add_column :applicants, :criminal_convicted, :boolean
    add_column :applicants, :criminal_convicted_value, :text
    add_column :applicants, :address_line_1, :string
    add_column :applicants, :address_line_2, :string
    add_column :applicants, :suburb, :string
    add_column :applicants, :city, :string
    add_column :applicants, :state, :string
    add_column :applicants, :postcode, :string
    add_column :applicants, :country, :string
    add_column :applicants, :phone, :string
    add_column :applicants, :skype, :string
    add_column :applicants, :link_to_video, :text
    add_column :applicants, :emergency_contact_name, :string
    add_column :applicants, :emergency_contact_email, :string
    add_column :applicants, :emergency_contact_phone, :string
    add_column :applicants, :emergency_contact_relation, :string

  end
end
