class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create 
    # @movies = []
    # @movie_info = Movie.details(params[:id])
    # @comment = Comment.new()
    # @comment.content = params["comment"][:content]
    # @comment.user_id = current_user.id
    # @comment.movie_id = params["comment"][:movie_id]
    # @comment = Comment.new(comment_params)
    @comment = current_user.comments.build(comment_params)
    
    
    # if @movie_info.present?
    #   results = @movie_info
    #   results.each do |result|
    #     movie = Movie.new(data(result))
    #     @movies << movie
    #   end
    # end
    
    # @movies.each do |movie|
    #   unless Movie.all.include?(movie)
    #     movie.save
    #   end
    # end
    
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:content, :user_id, :movie_id)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
    
    # def data(result)
    #   title       = @movie_info["title"]
    #   poster_path = @movie_info["poster_path"]
    #   {
    #     title: title,
    #     poster_path: poster_path
    #   }
    # end  
end
