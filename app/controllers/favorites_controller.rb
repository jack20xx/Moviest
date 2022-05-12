class FavoritesController < ApplicationController
  def create
    @favorite = current_user.favorites.create(comment_id: params[:comment_id])
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @comment = Comment.find(params[:comment_id])
    @favorite = current_user.favorites.find_by(comment_id: @comment.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
