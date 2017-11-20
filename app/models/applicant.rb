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
  has_many :references, dependent: :destroy

  #adding paperclip for profile pic upload
  has_attached_file :picture#, styles: {medium: "220x220>", small: "150x150>", thumb: "100x100>"}#, default_url: "/system/image-missing.png"
  validates_attachment_size :picture, :less_than => 1.megabytes
  validates_attachment :picture, content_type: {content_type: ['image/jpeg', 'image/png']}
  # process_in_background :picture

  #adding paperclip for resume upload
  has_attached_file :resume, :path => "public/system/:class/:attachment/:id/:filename", :url => "/system/:class/:attachment/:id/:basename.:extension"
  validates_attachment_size :resume, :less_than => 1.megabytes
  validates_attachment :resume, content_type: {content_type: ["application/pdf"]}

  def personal_details_json
    response = {
        profile_pic_url: self.picture,
        cv_url: self.resume.exists? ? self.resume.url : nil,
        personal_details: {
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
        languages: create_langauges_json,
        contact_details: {
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
        criminal_convictions: {
            criminal_convicted: self.criminal_convicted,
            criminal_convicted_value: self.criminal_convicted_value
        },
        emergency_contact: {
            emergency_contact_name: self.emergency_contact_name,
            emergency_contact_email: self.emergency_contact_email,
            emergency_contact_phone: self.emergency_contact_phone,
            relationship_to_candidate: self.emergency_contact_relation
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
          id: d.id,
          name: d.name,
          gender: d.gender,
          dob: d.dob,
          relation: d.relation
      }
      dependents << res
    end
    dependents
  end

  def create_langauges_json
    languages = []
    self.languages.each do |lang|
      res = {
          id: lang.id,
          name: lang.name,
          proficiency: lang.proficiency
      }
      languages << res
    end
    languages
  end

  def email
    self.user.email rescue nil
  end

  def qualification_and_licences_json
    response = {
        qualifications: create_qualifications_json,
        licences: create_licences_json,
        success: true
    }
  end

  def create_licences_json
    licences = []
    self.licences.each do |l|
      res = {
          id: l.id,
          name: l.name,
          country: l.country,
          registration_no: l.registration_no,
          copy: l.copy.exists? ? l.copy.url : nil,
          copy_file_name: l.copy_file_name
      }
      licences << res
    end
    licences
  end

  def create_qualifications_json
    qualifications = []
    self.qualifications.each do |q|
      res = {
          id: q.id,
          qualification_type: q.qualification_type,
          name: q.name,
          place_of_study: q.place_of_study,
          country: q.country,
          subjects: (eval(q.subjects) rescue nil),
          duration: q.duration,
          date_of_completion: q.date_of_completion
      }
      qualifications << res
    end
    qualifications
  end

  def experiences_json
    response = {
        experiences: create_experiences_json,
        success: true
    }
  end

  def create_experiences_json
    experiences = []
    self.experiences.each do |e|
      res = {
          id: e.id,
          curriculum: e.curriculum,
          name_of_school: e.name_of_school,
          country: e.country,
          region: e.region,
          school_level: e.school_level,
          position: e.position,
          subjects_taught: (eval(e.subjects_taught) rescue nil),
          from: e.from,
          to: e.to
      }
      experiences << res
    end
    experiences
  end

  def extra_json
    response = {
        extra_docs: create_extra_docs,
        registered_teacher: self.registered_teacher,
        can_coach_activities: self.can_coach_activities,
        interests: self.interests,
        skills: self.skills,
        other_experiences: self.other_experiences,
        comments: self.comments,
        total_relevant_experience: self.total_relevant_experience,
        success: true
    }
  end

  def create_extra_docs
    docs = []
    self.applicant_documents.each do |ad|
      res = {
          id: ad.id,
          file_name: ad.file_file_name,
          file: ad.file.exists? ? ad.file.url : nil
      }
      docs << res
    end
    docs
  end

  def referals_json
    response = {
        referals: create_referals_json,
        success: true
    }
  end

  def create_referals_json
    # referals = []
    self.references.group_by(&:type).as_json

    # self.references.each do |r|
    #   res = {
    #       id: r.id,
    #       name: r.name,
    #       relation: r.relation,
    #       first_name: r.first_name,
    #       last_name: r.last_name,
    #       email: r.email,
    #       phone: r.phone,
    #       address_lin1: r.address_lin1,
    #       address_line2: r.address_line2,
    #       suburb: r.suburb,
    #       city: r.city,
    #       state: r.state,
    #       country: r.country,
    #       school_name: r.school_name,
    #       school_city: r.school_city,
    #       school_state: r.school_state,
    #       school_country: r.school_country,
    #       worked_from: r.worked_from,
    #       worked_to: r.worked_to,
    #       type: r.type
    #   }
    #   referals << res
    # end
    # referals
  end

  PERSONAL_DETAILS_ALLOWED_PARAMS = [:country_of_citizenship, :country_of_birth, :eu_passport, :dob, :gender, :marital_status, :other_citizenship, :other_citizenship_country]
  PERSONAL_CONTACT_ALLOWED_PARAMS = [:address_line_1, :address_line_2, :suburb, :city, :state, :postcode, :country, :phone, :alt_email, :skype]
  PERSONAL_CRIMINAL_PARAMS = [:criminal_convicted, :criminal_convicted_value]
  PERSONAL_DETAILS_EMERGENCY_PARAMS = [:emergency_contact_name, :emergency_contact_email, :emergency_contact_phone, :emergency_contact_relation]
  EXTRA_INFORMATION_PARAMS = [:registered_teacher, :can_coach_activities, :interests, :skills, :other_experiences, :comments, :total_relevant_experience]
  OTHER_INFO_PARAMS = [:first_name, :last_name, :link_to_video]
  def update_extra_info(params)
    self.update_attributes(params.slice(*EXTRA_INFORMATION_PARAMS))
  end

  def update_other_info(params)
    self.update_attributes(params.slice(*OTHER_INFO_PARAMS))
  end

  def update_personal_details(params)
    self.update_attributes(params.slice(*PERSONAL_DETAILS_ALLOWED_PARAMS))
  end

  def update_contact_detail(params)
    ActiveRecord::Base.transaction do
      user = self.user
      user.email = params[:email]
      user.save
      self.update_attributes(params.slice(*PERSONAL_CONTACT_ALLOWED_PARAMS))
    end
  end

  def update_criminal_details(params)
    self.update_attributes(params.slice(*PERSONAL_CRIMINAL_PARAMS))
  end

  def update_emergency_contact(params)
    self.update_attributes(params.slice(*PERSONAL_DETAILS_EMERGENCY_PARAMS))
  end

  def self.get_applicant_by_auth_token_and_email auth_token, email
    self.joins(:user).find_by('users.auth_token': auth_token, 'users.email': email)
  end

end
