class School < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :jobs, dependent: :destroy
  before_save :add_email

  scope :activated, -> {where(active: true)}

  SCHOOLS_ALLOWED_PARAMS = [:country_of_citizenship, :country_of_birth,
                            :eu_passport, :dob, :gender, :marital_status,
                            :other_citizenship, :other_citizenship_country,
                            :designation, :email, :first_name, :last_name,
                            :middle_name, :name, :title, :step_no, :city,
                            :country, :fax, :geographic_region, :governed_by,
                            :phone, :postal_code, :school_name, :state, :street_1,
                            :street_2, :submitted_by, :submitted_by_email,
                            :website, :year_founded, :percent_complete, :details_updated]

  def update_school(params)
    self.update_attributes(params.slice(*SCHOOLS_ALLOWED_PARAMS))
  end

  def self.get_school_by_auth_token_and_email auth_token, email
    self.joins(:user).find_by('users.auth_token': auth_token, 'users.email': email)
  end

  def add_email
    self.email = self.user.email rescue nil
  end
end
