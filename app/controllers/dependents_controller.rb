class DependentsController < ApplicationController
  include ApplicantConcern

  def create_dependent
    dependent = Dependent.create_or_update_dependent(@applicant, dependent_params)
    if dependent
      render :json => {dependent: @applicant.dependents.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Dependent could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_dependent
    dependent = Dependent.create_or_update_dependent(@applicant, dependent_params)
    if dependent
      render :json => {dependent: @applicant.dependents.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Dependent could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      dependent = Dependent.find_dependent_by_applicant(@applicant, params[:id])
      if dependent
        dependent.destroy
        render :json => {dependent: dependent.as_json, success: true, message: "Dependent deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Dependent cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete dependent without ID."), success: false, status: 400
    end
  end

  private

  def dependent_params
    params.require(:data).permit(Dependent::DEPENDENT_ALLOWED_PARAMS).merge(params[:id])
  end

end
