class ApplicationController < ActionController::Base
  # We depend on our auth_token module here.
  require 'auth_token'

  skip_before_filter :verify_authenticity_token

  protect_from_forgery with: :exception
    include Pundit
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    ##
    # This method can be used as a before filter to protect
    # any actions by ensuring the request is transmitting a
    # valid JWT.
    def verify_jwt_token
      head :unauthorized if request.headers['Authorization'].nil? ||
          !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
    end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
