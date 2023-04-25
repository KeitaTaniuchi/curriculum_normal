class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: I18n.t('.flash.user_register_success')
    else
      flash.now[:danger] = I18n.t('.flash.user_register_failed')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :email, :password, :password_confirmation)
  end
end
