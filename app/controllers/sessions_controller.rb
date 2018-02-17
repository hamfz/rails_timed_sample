class SessionsController < Devise::SessionsController

  ## Todo: default devise respond_with/responder doesn't seem to be playing nice with turbolinks/rails5
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    redirect_to after_sign_in_path_for(resource)
  end

end
