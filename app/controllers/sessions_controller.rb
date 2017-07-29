class SessionsController < Devise::SessionsController
  layout 'auth_layout', only: [:new, :edit]
end
