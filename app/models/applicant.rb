class Applicant < ApplicationRecord
  has_many :applications
  has_many :jobs, through: :applications
  has_many :experiences, dependent: :destroy
  has_many :qualifications, dependent: :destroy
  has_many :licences, dependent: :destroy
  has_many :dependents, dependent: :destroy
  has_many :applicant_documents, dependent: :destroy
  belongs_to :user, dependent: :destroy

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
        profile_pic_url: "",
        cv_url: "",
        personal_details:{},
        dependents:{},
        contact_details:{},
        criminal_convictions:{},
        first_name: "",
        last_name: "",
        link_to_video: "",
        success: true
    }
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
