class ApplicantsController < ApplicationController
  before_action :set_applicant#, only: [:profile, :qualifications_and_licences]

  def profile
    if @applicant
      render :json => @applicant.personal_details_json, success: true, status: 200
    end
  end

  def qualifications_and_licences
    if @applicant
      render :json => @applicant.qualification_and_licences_json
    end
  end

  def experiences
    if @applicant
      render :json => @applicant.experiences_json
    end
  end

  def extra
    if @applicant
      render :json => @applicant.extra_json
    end
  end

  def referals
    if @applicant
      render :json => @applicant.referals_json
    end
  end

  private
  def set_applicant
    @applicant = Applicant.get_applicant_by_auth_token_and_email(get_token_header, get_email_header)
    applicant_not_found unless @applicant
  end

  def applicant_not_found
    render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
  end
end
