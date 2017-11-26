class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!, :authenticate_user_from_token!, :only => [:create, :new]
  skip_before_action :verify_signed_out_user, :only => [:destroy], :if => Proc.new {|c| c.request.format == 'application/json'}
  # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  respond_to :json, :html

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def create

    resource = resource_from_credentials
    #build_resource
    if request.format == 'application/json' && resource && resource.attempts_remaining == 0
      unless resource.access_locked?
        resource.lock_access!
      end
      render json: {success: false, message: 'You have exceeded the maximum login attempts. Please follow the instructions in the email to unlock your account.'}, status: 401 and return
    end

    #login here
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        return invalid_login_attempt unless resource
        if resource.active_for_authentication?
          if resource.valid_password?(params[:user][:password])
            resource.failed_attempts = 0
            # resource.last_sign_in_at = Time.now
            resource.last_activity_at = Time.now
            resource.last_sign_in_ip = resource.current_sign_in_ip
            resource.current_sign_in_ip = request.ip
            resource.auth_token = nil
            resource.save(validate: false)
            login_response = {user: {email: resource.email, :auth_token => resource.auth_token, user_type: resource.user_type}, success: true}
            login_response[:user].merge!({step_no: resource.school.try(:step_no), new_registration: resource.school.try(:new_registration), details_updated: resource.school.try(:details_updated)}) if resource.user_type == User::SCHOOL
            render :json => login_response, success: true, status: :created
          else
            invalid_login_attempt({attempts_remaining: resource.attempts_remaining})
          end
        else
          render json: {success: false, message: 'Your account is inctive. Please follow the instructions in email to confirm it.'}, status: 401 and return
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_by_auth_token(request.headers['X-API-TOKEN'])
        if user
          user.reset_authentication_token!
          render :json => {:message => 'Session deleted.', success: true}, :success => true, :status => 200
        else
          render :json => {:message => 'Invalid token.', success: false}, :status => 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt(options = {})
    warden.custom_failure!
    render json: {success: false, message: 'Error with your login or password', options: options}, status: 401
  end

  def resource_from_credentials
    data = {email: params[:user][:email]}
    if res = resource_class.find_for_database_authentication(data)
      if res.valid_password?(params[:user][:password])
        res
      else
        res.failed_attempts += 1
        res.save(validate: false)
        res
      end
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
