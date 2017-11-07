class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :authenticate_user!, :authenticate_user_from_token!, :only => [:create, :new]
  after_action: :create_school_or_applicant, only: [:create]
  before_action: :validate_user_type, only: :create
  respond_to :json

  VALID_USER_TYPES = ["applicant", "school"]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:timezone, :user_type])
  end

  def create_school_or_applicant
    user = User.find_by_email(params[:email])
    if params[:user_type].downcase == "applicant"
      user.applicant = Applicant.new
      user.save
    elsif params[:user_type].downcase == "school"
      user.applicant = School.new
      user.save
    end
  end

  def validate_user_type
    unless VALID_USER_TYPES.include?(params[:user_type].downcase)
      render :json => {message: "Invalid User type", success: false}, success: true, status: 400
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:timezone, :user_type])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
