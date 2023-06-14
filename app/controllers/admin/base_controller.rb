class Admin::BaseController < ApplicationController
  before_action :check_admin
  # layoutの宣言
  # もし宣言が無ければコントローラはapp/views/layouts/application.html.erbをレイアウトとして探索する
  layout 'admin/layouts/application'

  private

  def not_authenticated
    redirect_to admin_login_path, danger: 'ログインしてください'
  end

  def check_admin
    redirect_to root_path, danger: '管理者権限を持っていません' unless current_user.admin?
  end
end
