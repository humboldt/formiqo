class RegistrationsController < Devise::RegistrationsController
  layout 'auth_layout', only: [:new]


end
