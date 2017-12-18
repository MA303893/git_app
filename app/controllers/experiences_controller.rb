class ExperiencesController < ApplicationController
  include ApplicantConcern

  def create_experiences
    experience = Experience.create_or_update_experience(@applicant, experience_params)
    if experience
      render :json => {experiences: @applicant.experiences.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Experience could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_experiences
    experience = Experience.create_or_update_experience(@applicant, experience_params, params[:id])
    if experience
      render :json => {experiences: @applicant.experiences.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Experience could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      experience = Experience.find_experience_by_applicant(@applicant, params[:id])
      if experience
        experience.destroy
        render :json => {experience: experience.as_json, success: true, message: "Experience deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Experience cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete Experience without ID."), success: false, status: 400
    end
  end

  private

  def experience_params
    params.require(:data).permit(Experience::EXPERIENCE_ALLOWED_PARAMS)
  end
end
