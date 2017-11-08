class Experience < ApplicationRecord
  belongs_to :applicant

  EXPERIENCE_ALLOWED_PARAMS = [:curriculum, :name_of_school, :country, :region, :school_level,
                              :position, :subjects_taught, :from, :to
  ]


  def self.create_or_update_experience(applicant, params, id = nil)
    if id
      experience = Experience.find_dependent_by_applicant(applicant, id)
      if experience
        experience.update_attributes(params.slice(*EXPERIENCE_ALLOWED_PARAMS))
        return experience
      else
        return nil
      end
    else #new experience
      experience = Experience.new
      experience.assign_attributes(params.slice(*EXPERIENCE_ALLOWED_PARAMS))
      experience.applicant = applicant
      experience.save
      return experience
    end
  end

  def self.find_experience_by_applicant(applicant, id)
    experience = Experience.find_by(id: id, applicant: applicant)
  end
end
