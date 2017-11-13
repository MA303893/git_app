class Users::UnlocksController < Devise::UnlocksController
  # GET /resource/unlock/new
  # def new
  #   super
  # end

  # POST /resource/unlock
  # def create
  #   super
  # end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    self.resource = resource_class.unlock_access_by_token(params[:unlock_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message! :notice, :unlocked
      # respond_with_navigational(resource){ redirect_to after_unlock_path_for(resource) }
      # render :json => {user: {email: resource.email, :message => "Your account has been unlocked."}}, success: true and return
      redirect_to USER_CONFIRMATION_URL+"/?unlock=true"
    else
      # respond_with_navigational(resource.errors, status: :unprocessable_entity) {render :new}
      render :json => {user: {email: resource.email, :errors => resource.errors, status: :unprocessable_entity}}, success: true and return
    end
  end

  protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   if is_navigational_format?
  #     # (controller: 'home', action: 'index', message: "Your account has been unlocked.")
  #     root_path(resource, message: "Your account has been unlocked.")
  #     # render :json => {user: {email: resource.email, :message => "Your account has been unlocked."}}, success: true and return
  #   end
  # end
end
