class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json {
        render json: {message: "Welcome #{request.headers['X-API-EMAIL']}"}, status: 200
      }
    end
  end
  def get_user
    user = User.find_by(email: request.headers['X-API-EMAIL'])
    render json: user, status: 200
  end
end
