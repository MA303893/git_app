class SchoolsController < ApplicationController
  before_action :set_school #, only: [:profile, :qualifications_and_licences]
  # skip_before_action :authenticate_user!

  def profile
    if @school
      render :json => @school.as_json, success: true, status: 200
    end
  end

  def update

  end

  def get_data_from_params
    params[:data]
  end

  private
  def set_school
    @school = School.get_school_by_auth_token_and_email(get_token_header, get_email_header)
    school_not_found unless @school
  end

  def school_not_found
    render :json => unsuccessful_response("School Not Found"), success: false, status: 404
  end
end
