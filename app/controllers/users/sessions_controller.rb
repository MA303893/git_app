class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!, :only => [:create, :new]
  skip_before_action :verify_signed_out_user, :only => [:destroy], :if => Proc.new {|c| c.request.format == 'application/json'}
  # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  respond_to :json, :html
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def create

    respond_to do |format|
      format.html {
        super
      }
      format.json {

        resource = resource_from_credentials
        #build_resource
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:user][:password])
          render :json => {user: {email: resource.email, :auth_token => resource.auth_token}}, success: true, status: :created
        else
          invalid_login_attempt
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
          render :json => {:message => 'Session deleted.'}, :success => true, :status => 200
        else
          render :json => {:message => 'Invalid token.'}, :status => 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render json: {success: false, message: 'Error with your login or password'}, status: 401
  end

  def resource_from_credentials
    data = {email: params[:user][:email]}
    if res = resource_class.find_for_database_authentication(data)
      if res.valid_password?(params[:user][:password])
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
