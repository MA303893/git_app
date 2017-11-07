class Qualification < ApplicationRecord
  belongs_to :applicant

  QUAL_ALLOWED_PARAMS = [:name, :place_of_study, :country, :subjects, :duration, :date_of_completion, :qualification_type]

  def self.create_or_update_qualification(applicant, params, id = nil)
    if id
      qual = Qualification.find_qualification_by_applicant(applicant, id)
      if qual
        qual.update_attributes(params.slice(*QUAL_ALLOWED_PARAMS))
        return qual
      else
        return nil
      end
    else #new dependent
      qual = Qualification.new
      qual.assign_attributes(params.slice(*QUAL_ALLOWED_PARAMS))
      qual.applicant = applicant
      qual.save
      return qual
    end
  end

  def self.find_qualification_by_applicant(applicant, id)
    qual = Qualification.find_by(id: id, applicant: applicant)
  end
end
