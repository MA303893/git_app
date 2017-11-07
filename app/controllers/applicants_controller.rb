class ApplicantsController < ApplicationController
  before_action :set_applicant #, only: [:profile, :qualifications_and_licences]
  skip_before_action :authenticate_user!

  def update_personal_details
    if @applicant
      @applicant.update_personal_details
    end
  end

  def profile
    if @applicant
      render :json => @applicant.personal_details_json, success: true, status: 200
    end
  end

  def update_profile
    case params[:type]
      when 'personal_details'
      when 'contact_details'
      when 'criminal_convictions'
      when 'emergency_contact'
      when 'other'
      else
        #update fn ln, link_to_video etc
    end
  end

  def update_picture
    if @applicant.update_attributes(picture: params[:picture])
      render :json => {profile_pic_url: @applicant.picture.url, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Could not upload the image").merge({errors: @applicant.errors}), success: false, status: 404
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

  def create_extra

  end

  def update_extra

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
