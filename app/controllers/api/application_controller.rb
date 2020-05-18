class Api::ApplicationController < ApplicationController
  include AuthToken

  respond_to    :json
  before_action :authenticate_api_user!

  def authenticate_api_user!()
    authenticate_user_from_token!
    authenticate_user! if user_signed_in?
  end
end
