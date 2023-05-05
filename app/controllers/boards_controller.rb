class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, success: I18n.t('.flash.created', item: Board.model_name.human)
    else
      flash.now[:danger] = I18n.t('.flash.not_created', item: Board.model_name.human)
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
