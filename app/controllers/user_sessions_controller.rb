class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to boards_path, success: I18n.t('.flash.succeeded', item: I18n.t('.defaults.login'))
    else
      flash.now[:danger] = I18n.t('.flash.failed', item: I18n.t('.defaults.login'))
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: I18n.t('.flash.succeeded', item: I18n.t('.defaults.logout'))
  end
end
