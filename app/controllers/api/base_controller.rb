class Api::BaseController < ActionController::API
  include Knock::Authenticable
  before_action :authenticate_user
  # devise defines this, while knock is using `method_missing`
  undef_method :current_user
end
