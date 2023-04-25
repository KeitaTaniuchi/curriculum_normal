class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to boards_path, success: I18n.t('.flash.login_success')
    else
      flash.now[:danger] = I18n.t('.flash.login_failed')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: I18n.t('.flash.logout')
  end
end
