class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception


  # rescue_from CanCan::AccessDenied do
  #   if current_user.present?
  #     redirect_to subscriptions_path, notice: "You subscription's expired. Please prolong it to continue"
  #   else
  #     redirect_to root_path
  #   end
  # end
end
