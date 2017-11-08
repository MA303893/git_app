class Reference < ApplicationRecord
  belongs_to :applicant

  REFERENCE_ALLOWED_PARAMS = [
      :name, :relation, :first_name, :last_name, :email, :phone, :address_lin1, :address_line2, :suburb, :city,
      :state, :country, :school_name, :school_city, :school_state, :school_country, :worked_from, :worked_to, :type
  ]


  def self.create_or_update_reference(applicant, params, id = nil)
    if id
      reference = Reference.find_reference_by_applicant(applicant, id)
      if reference
        reference.update_attributes(params.slice(*REFERENCE_ALLOWED_PARAMS))
        return reference
      else
        return nil
      end
    else #new reference
      reference = Reference.new
      reference.assign_attributes(params.slice(*REFERENCE_ALLOWED_PARAMS))
      reference.applicant = applicant
      reference.save
      return reference
    end
  end

  def self.find_reference_by_applicant(applicant, id)
    reference = Reference.find_by(id: id, applicant: applicant)
  end
end
