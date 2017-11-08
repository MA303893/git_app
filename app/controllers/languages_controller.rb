class LanguagesController < ApplicationController
  include ApplicantConcern

  def create_language
    language = Language.create_or_update_language(@applicant, language_params)
    if language
      render :json => {language: @applicant.languages.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Language could not be added! Please try again."), success: false, status: 400
    end
  end

  def update_language
    language = Language.create_or_update_language(@applicant, language_params, params[:id])
    if language
      render :json => {language: @applicant.languages.as_json, success: true}, success: true, status: 200
    else
      render :json => unsuccessful_response("Language could not be updated! Please try again."), success: false, status: 400
    end
  end

  def destroy
    if params[:id]
      language = Language.find_language_by_applicant(@applicant, params[:id])
      if language
        language.destroy
        render :json => {language: language.as_json, success: true, message: "Language deleted!"}, success: true, status: 200
      else
        render :json => unsuccessful_response("Language cannot be deleted. You are not authorized!"), success: false, status: 400
      end

    else
      render :json => unsuccessful_response("Cannot delete language without ID."), success: false, status: 400
    end
  end

  private

  def language_params
    params.require(:data).permit(Language::DEPENDENT_ALLOWED_PARAMS)
  end

end
