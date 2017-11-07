class QualificationsController < ApplicationController
  include ApplicantConcern

  def create_qualification
    qual_params[:subjects] = qual_params[:subjects].to_s rescue nil
    qual = Qualification.create_or_update_qualification(@applicant, qual_params)
    if qual
      render :json => {qualification: qual.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Qualification could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_qualifications
    params[:subjects] = params[:subjects].to_s
    qual = Qualification.create_or_update_qualification(@applicant, qual_params)
    if qual
      render :json => {qualification: qual.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Qualification could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      qual = Qualification.find_qualification_by_applicant(@applicant, params[:id])
      if qual
        qual.destroy
        render :json => {qualification: qual.as_json, success: true, message: "Qualification deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Qualification cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete qualification without ID."), success: false, status: 400
    end
  end

  private

  def qual_params
    params.require(:data).permit(Qualification::QUAL_ALLOWED_PARAMS)
  end
end
