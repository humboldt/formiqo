class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    redirect_to root_path, flash: { error: "Not authorized or subscription is expired" }
  end

  rescue_from ActiveRecord::RecordNotFound, with: :e_404



  def e_404
    render(file: 'public/404', layout: false, status: :not_found)
  end
end
