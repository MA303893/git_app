class ApplicantsController < ApplicationController
  before_action :applicant, only: [:profile]

  def profile
    if @applicant
      render :json => @applicant.personal_details_json, success: true, status: 200
    else
      render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
    end
  end

  def qualifications_and_licences
    #todo
  end

  def experience
    #todo
  end

  def extra_docs
    #todo
  end

  def refernces
    #todo
  end

  private
  def applicant
    @applicant = Applicant.get_applicant_by_auth_token_and_email(get_token_header, get_email_header)
  end
end
