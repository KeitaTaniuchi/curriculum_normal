class BookmarksController < ApplicationController
  def index
    @bookmark_boards = current_user.bookmark_boards
  end

  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    redirect_to boards_path, success: I18n.t('.flash.bookmarked')
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    redirect_to boards_path, success: I18n.t('.flash.bookmark_removed')
  end
end
