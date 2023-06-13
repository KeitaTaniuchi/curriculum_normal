class PasswordResetsController < ApplicationController
  # sorceryのReset-passwordのドキュメントを参考にしている
  # https://github.com/Sorcery/sorcery/wiki/Reset-password
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    # 有効期限付きのリセットコードを生成し、ユーザーにメールを送信する(トークンも生成する)
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: 'パスワードリセット手順を送信しました'
  end

  def edit
    @token = params[:id]
    # トークンでユーザーを検索し、有効期限切れもチェックします。
    # トークンが見つかり、有効であればそのユーザーを返します。
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを変更しました'
    else
      render :edit
    end
  end
end
