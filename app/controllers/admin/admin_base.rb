class Admin::AdminBase < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false
  layout 'admin_layout'
end
