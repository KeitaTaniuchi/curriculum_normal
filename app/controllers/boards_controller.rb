class BoardsController < ApplicationController
  before_action :find_board, only: %i[show edit update destroy]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
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

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), success: I18n.t('.flash.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = I18n.t('.flash.not_updated', item: Board.model_name.human)
      render :new
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, success: I18n.t('.flash.deleted', item: Board.model_name.human)
  end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def find_board
    @board = current_user.boards.find(params[:id])
  end
end
