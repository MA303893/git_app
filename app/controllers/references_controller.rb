class ReferencesController < ApplicationController
  include ApplicantConcern

  def create_referal
    reference = Reference.create_or_update_reference(@applicant, reference_params)
    if reference
      render :json => {references: @applicant.references.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Reference could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_referal
    reference = Reference.create_or_update_reference(@applicant, reference_params, params[:id])
    if reference
      render :json => {references: @applicant.references.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Reference could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      reference = Reference.find_reference_by_applicant(@applicant, params[:id])
      if reference
        reference.destroy
        render :json => {reference: reference.as_json, success: true, message: "Reference deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Reference cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete reference without ID."), success: false, status: 400
    end
  end

  private

  def reference_params
    params.require(:data).permit(Reference::REFERENCE_ALLOWED_PARAMS)
  end

end
