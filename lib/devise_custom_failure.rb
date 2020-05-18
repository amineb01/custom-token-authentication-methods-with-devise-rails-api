class DeviseCustomFailure < Devise::FailureApp

  def http_auth
    super
    @failed = { status: 401, error: 'Login Failed', success: false }.to_json
    self.response_body = @failed
    self.content_type = 'json'
  end
end
