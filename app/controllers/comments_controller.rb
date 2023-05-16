class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to board_path(comment.board), success: I18n.t('.flash.created', item: Comment.human_attribute_name(:body))
    else
      redirect_to board_path(comment.board), danger: I18n.t('.flash.not_created', item: Comment.human_attribute_name(:body))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
