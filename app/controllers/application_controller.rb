class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception, unless: Proc.new { |c| c.request.format == 'application/json' }
  protect_from_forgery prepend: true
  before_action :authenticate_user!
end
