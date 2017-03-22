class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def new_session_path(scope)
    new_user_session_path
  end
end
