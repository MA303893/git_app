class Dependent < ApplicationRecord
  belongs_to :applicant

  DEPENDENT_ALLOWED_PARAMS = [:name, :gender, :dob, :relation]


  def self.create_or_update_dependent(applicant, params)
    params = params.deep_symbolize_keys
    if params[:id]
      dependent = Dependent.find_dependent_by_applicant(applicant, params[:id])
      if dependent
        dependent.update_attributes(params.slice(*DEPENDENT_ALLOWED_PARAMS))
        return dependent
      else
        return nil
      end
    else #new dependent
      dependent = Dependent.new
      dependent.assign_attributes(params.slice(*DEPENDENT_ALLOWED_PARAMS))
      dependent.applicant = applicant
      dependent.save
      return dependent
    end
  end

  def self.find_dependent_by_applicant(applicant, id)
    dependent = Dependent.find_by(id: id, applicant: applicant)
  end
end
