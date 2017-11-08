class LicencesController < ApplicationController
  include ApplicantConcern

  def create_licence
    licence = Licence.create_or_update_licence(@applicant, licence_params)
    if licence
      render :json => {licences: @applicant.licences.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Licence could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_licence
    licence = Licence.create_or_update_licence(@applicant, licence_params, params[:id])
    if licence
      render :json => {licences: @applicant.licences.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Licence could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      licence = Licence.find_licence_by_applicant(@applicant, params[:id])
      if licence
        licence.destroy
        render :json => {licence: licence.as_json, success: true, message: "Licence deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Licence cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete licence without ID."), success: false, status: 400
    end
  end

  private

  def licence_params
    params.require(:data).permit(Licence::LICENCE_ALLOWED_PARAMS)
  end
end
