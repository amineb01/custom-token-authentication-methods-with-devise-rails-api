require 'active_support/concern'

module AuthToken
  extend ActiveSupport::Concern

  def authenticate_user_from_token!
    if ( authentication_token = request.headers[:token].presence )
      user = User.find_by authentication_token: authentication_token
      # amine
      if user && Devise.secure_compare( user.authentication_token, request.headers[ :token ] )
        sign_in  :user, user, store: false
      else
        # binding.pry
        render status: 401, json: { status: :error, message: "Login Failed" }
      end
    end
  end

end
