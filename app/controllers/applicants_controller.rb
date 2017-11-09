class ApplicantsController < ApplicationController
  before_action :set_applicant #, only: [:profile, :qualifications_and_licences]
  # skip_before_action :authenticate_user!

  # def update_personal_details
  #   if @applicant
  #     @applicant.update_personal_details
  #   end
  # end

  def profile
    if @applicant
      render :json => @applicant.personal_details_json, success: true, status: 200
    end
  end

  def update_profile

    case params[:type]
      when 'personal_details'
        @applicant.update_personal_details(get_data_from_params)
      when 'contact_details'
        @applicant.update_contact_detail(get_data_from_params)
      when 'criminal_convictions'
        @applicant.update_criminal_details(get_data_from_params)
      when 'emergency_contact'
        @applicant.update_emergency_contact(get_data_from_params)
      when 'other'
        @applicant.update_other_info(get_data_from_params)
      when 'extra'
        @applicant.update_extra_info(get_data_from_params)
    end
    # @applicant.save
    if @applicant.errors.count == 0
      render :json => @applicant.personal_details_json, success: true, status: 200
    else
      render :json => unsuccessful_response("Update unsuccessful!").merge({errors: @applicant.errors}), success: false, status: 400
    end
  end

  def get_data_from_params
    params[:data]
  end

  def update_picture
    if @applicant.update_attributes(picture:  Base64.decode64(params[:picture]))
      render :json => {profile_pic_url: @applicant.picture.url, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Could not upload the image").merge({errors: @applicant.errors}), success: false, status: 400
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
