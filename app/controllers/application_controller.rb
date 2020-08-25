class ApplicationController < ActionController::Base

  # login後に転送する(=> tops_path)
  def after_sign_in_path_for(user)
    root_path
  end

  # logout後に転送する(=> /users/sign_in)
  def after_sign_out_path_for(user)
    new_user_session_path
  end

  protected # クラス内、同一パッケージ、サブクラスからアクセス可能

  def configure_permitted_parameters
    # signup時にstrong_parameterを渡す
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])

    # update時にstrong_parameterを渡す
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
