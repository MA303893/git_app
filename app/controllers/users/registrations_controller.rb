class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :validate_user_for_authentication, only: [:create]
  skip_before_action :authenticate_user!, :authenticate_user_from_token!, :only => [:create, :new]
  after_action :create_school_or_applicant, only: [:create]
  after_action :update_school_or_applicant, only: [:update]
  before_action :validate_user_type, only: [:create]
  respond_to :json

  VALID_USER_TYPES = [User::APPLICANT, User::SCHOOL]

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:timezone, :user_type, :user_info])
  end

  def validate_user_for_authentication
    user = User.find_by_email(params[:user][:email])
    if user && !user.active_for_authentication?
      render :json => {message: "User is already registered! Please follow the instructions in the email to confirm your account.", success: false}, success: false, status: 400 and return
    end
  end

  def create_school_or_applicant
    user = User.find_by_email(params[:user][:email])
    if user
      if params[:user][:user_type].downcase == User::APPLICANT
        applicant = user.applicant || Applicant.new
        applicant.first_name = params[:user][:user_info][:first_name]
        applicant.last_name = params[:user][:user_info][:last_name]
        applicant.alt_email = params[:user][:user_info][:alt_email]
        user.applicant = applicant
        # user.save
      elsif params[:user][:user_type].downcase == User::SCHOOL
        school = user.school || School.new
        school.school_name = params[:user][:user_info][:school_name]
        user.school = school
        # user.save
      end
    else
      render :json => {message: "User could not be registered! Please try again.", success: false}, success: false, status: 400 and return
    end
  end

  def update_school_or_applicant
    user = User.find_by_email(params[:user][:email])
    if params[:user][:user_type].downcase == User::APPLICANT
      applicant = user.applicant
      applicant.first_name = params[:user][:user_info][:first_name]
      applicant.last_name = params[:user][:user_info][:last_name]
      applicant.alt_email = params[:user][:user_info][:alt_email]
      applicant.save
    elsif params[:user][:user_type].downcase == User::SCHOOL
      school = user.school
      school.school_name = params[:user][:user_info][:school_name]
      school.save
      endg
    end

    def validate_user_type
      if params[:user][:user_type].nil?
        render :json => {message: "Invalid User type|User type must be present", success: false}, success: false, status: 400 and return
      elsif !VALID_USER_TYPES.include?(params[:user][:user_type].downcase)
        render :json => {message: "Invalid User type", success: false}, success: false, status: 400 and return
      end
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:timezone, :user_type, :user_info])
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
end
