# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # Gmailを使用してのソーシャルログイン(G-Suiteにも対応)
  def google_oauth2
    callback_for(:google)
  end

  # 各ソーシャルログインの共通処理
  def callback_for(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    redirect_to new_user_session_path and return if @user.nil?

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_session_path
    end
  end

  # ソーシャルログインに失敗した場合
  def failure
    redirect_to new_user_session_path
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
