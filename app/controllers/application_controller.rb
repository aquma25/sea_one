class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # login後に転送する(=> tops_path)
  def after_sign_in_path_for(user)
    root_path
  end

  # logout後に転送する(=> /users/sign_in)
  def after_sign_out_path_for(user)
    new_user_session_path
  end

  protected

  # signup,update時にstrong_parameterを渡す
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
