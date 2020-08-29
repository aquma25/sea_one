# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    new_password = user_params["password"]
    new_password_confirmation = user_params["password_confirmation"]
    reset_password_token = params["user"]["reset_password_token"]

    @user = User.find_by(reset_password_token: reset_password_token)
    redirect_to new_user_password_path, notice: 'もう一度メール送信から行ってください' if @user.nil?

    if new_password == new_password_confirmation
      # passwordを暗号化して更新
      @user.update(encrypted_password: Devise::Encryptor.digest(User, new_password))
      redirect_to new_user_session_path, notice: '新しいパスワードの更新が完了しました'
    else
      redirect_to edit_user_password_path(reset_password_token: reset_password_token), notice: 'パスワードが一致しません'
    end
  end

  protected

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
