class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, :only => [ :new, :create ]
  skip_before_action :allow_params_authentication!, :only => :create
  skip_before_action { request.env["devise.skip_timeout"] = true }
  skip_before_action :verify_authenticity_token

  prepend_view_path 'app/views/devise'

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
        respond_to do |format|
                format.json { render :json => {}, :status => :ok }
                format.html { respond_with resource, :location => after_sign_in_path_for(resource) } 
        end
  end

  # DELETE /resource/sign_out
  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end


  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
end
# # This is an example of how to extend the devise sessions controller
# # to support JSON based authentication and issuing a JWT.
# class Users::SessionsController < Devise::SessionsController
#   # Require our abstraction for encoding/deconding JWT.
#   require 'auth_token'

#   # Disable CSRF protection
#   skip_before_action :verify_authenticity_token

#   # Be sure to enable JSON.
#   respond_to :html, :json

#   # POST /resource/sign_in
#   def create

#     # This is the default behavior from devise - view the sessions controller source:
#     # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb#L16
#     self.resource = warden.authenticate!(auth_options)
#     set_flash_message(:notice, :signed_in) if is_flashing_format?
#     sign_in(resource_name, resource)
#     yield resource if block_given?

#     # Here we're deviating from the standard behavior by issuing our JWT
#     # to any JS based client.
#     token = AuthToken.issue_token({ user_id: resource.id })
#     respond_to do |format|
#       format.json { render json: {user: resource.email, token: token} }
#     end

#     # The default behavior would have been to simply fire respond_with:
#     # respond_with resource, location: after_sign_in_path_for(resource)
#   end

# end
