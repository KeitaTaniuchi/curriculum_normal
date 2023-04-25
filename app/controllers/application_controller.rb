class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, danger: I18n.t('.flash.require_login')
  end
end
