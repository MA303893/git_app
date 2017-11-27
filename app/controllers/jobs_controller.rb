class JobsController < ApplicationController
  before_action :set_school , only: [:create, :update, :destroy]
  def index

  end

  def create

  end

  def update

  end

  def show

  end

  def destroy

  end

  private
  def set_school
    @school = School.get_school_by_auth_token_and_email(get_token_header, get_email_header)
    school_not_found unless @school
  end

  def school_not_found
    render :json => unsuccessful_response("School Not Found or Not authorized to perform the action!"), success: false, status: 404
  end
end
