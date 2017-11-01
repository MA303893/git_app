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
    if @applicant
      render :json => @applicant.qualification_and_licences_json
    else
      render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
    end
  end

  def experiences
    #todo
    if @applicant
      render :json => @applicant.qualification_and_licences_json
    else
      render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
    end
  end

  def extra
    #todo
    if @applicant
      render :json => @applicant.qualification_and_licences_json
    else
      render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
    end
  end

  def referals
    #todo
    if @applicant
      render :json => @applicant.qualification_and_licences_json
    else
      render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
    end
  end

  private
  def applicant
    @applicant = Applicant.get_applicant_by_auth_token_and_email(get_token_header, get_email_header)
  end
end
