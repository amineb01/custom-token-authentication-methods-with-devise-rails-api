class Api::V1::SessionsController < Devise::SessionsController
  include AuthToken

  skip_around_action :authenticate_user!, raise: false, only: :create
  skip_before_action :verify_signed_out_user, raise: false

  def create
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    current_user.reset_authentication_token!
    render  status: 200,
            json: {
              status: :success,
              message: "Logged in",
              data: {
                authentication_token: current_user.authentication_token,
                user: current_user
              }
            }

  end

  def destroy
    authenticate_user_from_token!
    warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render status: 200, json: { status: :success, message: :signed_out }
  end


  def failure
    render status: 401, json: {status: :error, message: "Login Failed" }
  end
end
