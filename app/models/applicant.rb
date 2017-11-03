class Applicant < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications
  has_many :experiences, dependent: :destroy
  has_many :qualifications, dependent: :destroy
  has_many :licences, dependent: :destroy
  has_many :dependents, dependent: :destroy
  has_many :applicant_documents, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :languages, dependent: :destroy

 #adding paperclip for profile pic upload
  has_attached_file :picture, styles: { medium: "300x300>",small: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_size :picture, :less_than => 1.megabytes
  validates_attachment :picture, content_type: { content_type: ['image/jpeg', 'image/png'] }

 #adding paperclip for resume upload
  has_attached_file :resume
  validates_attachment_size :resume, :less_than => 1.megabytes
  validates_attachment :resume, content_type: { content_type: "application/pdf" }

  def personal_details_json
    response = {
        profile_pic_url: self.picture.url,
        cv_url: self.resume.exists? ? self.resume.url : nil,
        personal_details:{
            country_of_citizenship: self.country_of_citizenship,
            country_of_birth: self.country_of_birth,
            eu_passport: self.eu_passport,
            dob: self.dob,
            gender: self.gender,
            marital_status: self.marital_status,
            other_citizenship: self.other_citizenship,
            other_citizenship_country: self.other_citizenship_country
        },
        dependents: create_dependents_json,
        contact_details:{
            address_line_1: self.address_line_1,
            address_line_2: self.address_line_2,
            suburb: self.suburb,
            city: self.city,
            state: self.state,
            postcode: self.postcode,
            country: self.country,
            email: self.email,
            alt_email: self.alt_email,
            phone: self.phone,
            skype: self.skype
        },
        criminal_convictions:{
            criminal_convicted: self.criminal_convicted,
            criminal_convicted_value: self.criminal_convicted_value
        },
        first_name: self.first_name,
        last_name: self.last_name,
        link_to_video: self.link_to_video,
        alias_name: self.alias_name,
        success: true
    }
  end

  def create_dependents_json
    dependents = []
    self.dependents.each do |d|
      res = {
          name: d.name,
          gender: d.gender,
          dob: d.dob,
          relation: d.relation
      }
      dependents << res
      dependents
    end
  end

  def email
    self.user.email rescue nil
  end

  def qualification_and_licences_json
    response = {
        qualifications: [],
        licences: [],
        success: true
    }
  end

  def experiences_json
    response = {
     experiences: [],
     success: true
    }
  end

  def extra_json
    #todo
    response = {
        success: true
    }
  end

  def referals_json
    #todo
    response = {
        referals: [],
        success: true
    }
  end

  def self.get_applicant_by_auth_token_and_email auth_token, email
    self.joins(:user).find_by('users.auth_token': auth_token, 'users.email': email)
  end
end
