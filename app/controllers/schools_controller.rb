class SchoolsController < ApplicationController
  before_action :set_school #, only: [:profile, :qualifications_and_licences]
  skip_before_action :set_school, only: [:index]

  def index
    @schools = School.all
    render :json => @schools.as_json, success: true, status: 200
  end

  def profile
    if @school
      render :json => @school.as_json, success: true, status: 200
    end
  end

  def update
    if @school
      @school.update_school(get_data_from_params)
      @school.new_registration = false
      @school.save
      if @school.errors.count == 0
        render :json => @school.as_json, success: true, status: 200
      else
        render :json => unsuccessful_response("Update unsuccessful!").merge({errors: @school.errors}), success: false, status: 400
      end
    end
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
