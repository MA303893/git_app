class ApplicantsController < ApplicationController
  before_action :applicant, only: [:show]
  def show
    if @applicant
      render :json => {applicant: @applicant.to_json, success: true}, success: true, status: 200
    else
      render :json => {message: "Applicant not found", success: false}, success: false, status: 404
    end

  end

  private
   def applicant
    @applicant = Applicant.find_by(id: params[:id]) if params[:id].present?
   end
end
