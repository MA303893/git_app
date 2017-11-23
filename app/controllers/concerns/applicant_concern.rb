module ApplicantConcern
  extend ActiveSupport::Concern

  included do
    helper_method :set_applicant, :applicant_not_found
    before_action :set_applicant
  end

  def set_applicant
    @applicant = Applicant.get_applicant_by_auth_token_and_email(get_token_header, get_email_header)
    applicant_not_found unless @applicant
  end

  def applicant_not_found
    render :json => unsuccessful_response("Applicant Not Found"), success: false, status: 404
  end
end