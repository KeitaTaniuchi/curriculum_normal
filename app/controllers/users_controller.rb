class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: I18n.t('.flash.created', item: User.model_name.human)
    else
      flash.now[:danger] = I18n.t('.flash.not_created', item: User.model_name.human)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :email, :password, :password_confirmation)
  end
end
