# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_likeable

  def create
    @like = current_user&.likes&.build(likeable: @likeable)
    if @like&.save
      redirect_back fallback_location: posts_path, notice: 'Liked!'
    else
      redirect_back fallback_location: posts_path, alert: 'You must be logged in to like.'
    end
  end

  def destroy
    @like = @likeable&.likes&.find_by(user: current_user)
    if @like
      @like.destroy
      redirect_back fallback_location: posts_path, notice: 'Unliked!'
    else
      redirect_back fallback_location: posts_path, alert: 'Cannot unlike.'
    end
  end

  private

  def find_likeable
    if params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    elsif params[:post_id]
      @likeable = Post.find(params[:post_id])
    end
  end
end
