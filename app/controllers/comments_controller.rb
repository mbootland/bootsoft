# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:destroy]
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'You must be logged in to create a comment.'
    end
  end

  def destroy
    if @comment&.user == current_user || current_user.admin?
      @comment.destroy
      redirect_back fallback_location: @post, notice: 'Comment deleted!'
    else
      redirect_back fallback_location: @post, alert: 'You can only delete your own comments.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
