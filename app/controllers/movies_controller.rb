class MoviesController < ApplicationController

  def search
    @search_term = params[:looking_for]
    @movie_results = Movie.search(@search_term)["results"]
  end
  
  def show
    @movies = []
    @movie_info = Movie.details(params[:id])
    @current_user_comment = Comment.find_by(user_id: current_user.id, movie_id: @movie_info["id"]) if logged_in?
    @comment = Comment.new if logged_in?
    
    if @movie_info.present?
      results = @movie_info
      results.each do |result|
        movie = Movie.new(data(result))
        @movies << movie
      end
    end
    
    @movies.each do |movie|
      unless Movie.all.include?(movie)
        movie.save
      end
    end
    
    if Movie.exists?(@movie_info["id"])
      @movie_db = Movie.find(@movie_info["id"])
      @comments = @movie_db.comments.paginate(page: params[:page])
    end
  end
  
  private
    def data(result)
      id          = @movie_info["id"]
      title       = @movie_info["title"]
      poster_path = @movie_info["poster_path"]
      {
        id:          id,
        title:       title,
        poster_path: poster_path
      }
    end  

end