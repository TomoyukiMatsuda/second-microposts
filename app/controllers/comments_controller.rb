class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: :destroy

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to micropost_url(@comment.micropost_id)
    else
      @micropost = @comment.micropost
      @comments = @micropost.comments.order(id: :desc)
      flash.now[:danger] = 'コメントできませんでした'
      render "microposts/show"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_back(fallback_location: micropost_url(@comment.micropost_id))
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, micropost_id: params[:micropost_id])
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
