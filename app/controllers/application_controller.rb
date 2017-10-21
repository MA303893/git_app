class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new {|c| c.request.format == 'application/json'}
  before_action :authenticate_user_from_token! , :if => Proc.new {|c| c.request.format == 'application/json'}
  before_action :authenticate_user!, except: [:user_unlock]
  respond_to :json, :html



  def user_unlock
    redirect_to :controller => 'users/unlocks', :action => 'show', unlock_token: params[:unlock_token]
  end

  protected

  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    # if request.format == 'application/json'
      if user && Devise.secure_compare(user.auth_token, user_auth_token)
        sign_in(user, store: false)
      else
        (render :json => {message: "Sorry invalid email or token."}, success: false, status: 401)
      end
    # end
  end

end
