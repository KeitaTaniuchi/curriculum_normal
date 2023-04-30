class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :asc)
  end
end
