class Licence < ApplicationRecord
  belongs_to :applicant

  #adding paperclip for licence copy upload
  has_attached_file :copy
  validates_attachment_size :copy, :less_than => 2.megabytes
  validates_attachment :copy, content_type: { content_type: "application/pdf" }


  LICENCE_ALLOWED_PARAMS = [:name, :country, :registration_no]


  def self.create_or_update_licence(applicant, params, id = nil)
    if id
      licence = Licence.find_licence_by_applicant(applicant, id)
      if licence
        licence.update_attributes(params.slice(*LICENCE_ALLOWED_PARAMS))
        return licence
      else
        return nil
      end
    else #new licence
      licence = Licence.new
      licence.assign_attributes(params.slice(*LICENCE_ALLOWED_PARAMS))
      licence.applicant = applicant
      licence.save
      return licence
    end
  end

  def self.find_licence_by_applicant(applicant, id)
    licence = Licence.find_by(id: id, applicant: applicant)
  end
end
