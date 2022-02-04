class MoviesController < ApplicationController

  def search
    @search_term = params[:looking_for]
    @movie_results = Movie.search(@search_term)["results"]
  end
  
  def show
    @movie_info = Movie.details(params[:id])
  end

end