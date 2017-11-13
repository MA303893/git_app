class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      # set_flash_message!(:notice, :confirmed)
      # respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
      # render :json => {user: {email: resource.email, :message => "Your account has been confirmed."}}, success: true and return
      redirect_to USER_CONFIRMATION_URL
    else
      # respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
      render :json => {user: {email: resource.email, :errors => resource.errors, status: :unprocessable_entity}}, success: true and return
    end
    # super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
