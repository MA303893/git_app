class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new {|c| c.request.format == 'application/json'}
  before_action :authenticate_user_from_token! , :if => Proc.new {|c| c.request.format == 'application/json'}
  before_action :authenticate_user!, except: [:user_unlock]
  respond_to :json, :html

  rescue_from Exception, :with => :render_500

  def render_500(exception)
    @exception = exception
    render :json => {errors: exception.message, success: false, message: "Please contact admin! code: A-C-12"}, success: false, status: 400
  end



  def user_unlock
    redirect_to :controller => 'users/unlocks', :action => 'show', unlock_token: params[:unlock_token]
  end

  def timezones
    zones = ActiveSupport::TimeZone.all
    if zones
      render :json => {time_zones: zones.map(&:name), success: true}, success: true, status: 200
    end
  end

  def languages
    langauges = I18nData.languages.values
    render :json => {languages: languages, success: true}, success: true, status: 200
  end

  def countries
    countries = CS.get
    render :json => {countries: countries, success: true}, success: true, status: 200
  end

  def states
    states = CS.get(params[:state])
    unless states.blank?
      render :json => {states: states, success: true}, success: true, status: 200
    else
      render :json => {states: states, success: false, message: "Invalid country code OR state not found for country."}, success: true, status: 404
    end
  end

  protected

  def get_email_header
    request.headers["X-API-EMAIL"].presence
  end

  def get_token_header
    request.headers["X-API-TOKEN"].presence
  end

  def authenticate_user_from_token!
    user_email = get_email_header
    user_auth_token = get_token_header
    user = user_email && User.find_by_email(user_email)

    # Notice how we use Dervise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    # if request.format == 'application/json'
      if user && Devise.secure_compare(user.auth_token, user_auth_token)
        if ((Time.now.to_f - user.last_activity_at.to_f) > Devise.timeout_in.to_f)
          #if user's token time is expired, then return 401
          render :json => unsuccessful_response("Sorry, your session has expired. Please login again to continue."), success: false, status: 401
        else
          #update user last_activity_at
          user.last_activity_at = Time.now
          user.save
        end
        sign_in(user, store: false)
      else
        render :json => unsuccessful_response("Sorry invalid email or token."), success: false, status: 401
      end
    # end
  end

  def unsuccessful_response(message)
    {message: message, success: false}
  end

end
