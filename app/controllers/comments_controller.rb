class CommentsController < ApplicationController
  include HTTParty
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  default_options.update(verify: false) # disable SSL verification(必要に応じて)
  default_params api_key: 'b8bb3dcba4118e40c8c7d59fa5dc78c6', language: "ja-JP" #共通パラメタ                 
  format :json

  # 指定の映画の詳細情報を取得
  # https://developers.themoviedb.org/3/movies/get-movie-detailsに参照
  def self.details id
    #base_uri "https://api.themoviedb.org/3/movie/#{id}"
    get("https://api.themoviedb.org/3/movie/#{id}", query: {} ) #パラメタなし
  end
  
  def create 
    # @movies = []
    # @movie_info = Movie.details(params[:id])
    # @comment = Comment.new()
    # @comment.content = params["comment"][:content]
    # @comment.user_id = current_user.id
    # @comment.movie_id = params["comment"][:movie_id]
    # @comment = Comment.new(comment_params)
    @comment = current_user.comments.build(comment_params)
    comment_count = Comment.where(movie_id: params[:id]).where(user_id: current_user.id).count
    
    
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
    if @comment.valid?
      if comment_count < 1 and request.path.include?("/ja") then
        @comment.save
        flash[:success] = "レビューが投稿されました。"
        # redirect_to root_url
        redirect_to "/ja/movies/#{@comment.movie_id}"
      elsif comment_count < 1 and request.path.include?("/en") then
        @comment.save
        flash[:success] = "Review posted!"
        # redirect_to root_url
        redirect_to "/en/movies/#{@comment.movie_id}"
      else
        flash[:success] = "Can't post a review twice on the same movie"
        redirect_to request.referrer || root_url
      end
      
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Review deleted"
    redirect_to request.referrer || root_url
  end
  
  def edit
    if request.path.include?("/ja")
      @movie_info = Movie.details(params[:movie_id])
    else
      @movie_info = Movie.details_en(params[:movie_id])
    end
    @comment = Comment.find(params[:id])
    
    if Movie.exists?(@movie_info["id"])
      @movie_db = Movie.find(@movie_info["id"])
      @comments = @movie_db.comments.paginate(page: params[:page])
    end
    render :layout => 'application2'
    # @comment.movie   = Movie.find(params[:movie_id])
    # if @comment.user_id != current_user.id
    #   redirect_to comment_path, alert: "access error"
    # end
  end
  
  def update
    @comment = Comment.find(params[:id])
    # @comment = Comment.find(params[:id])
    # @movie   = Movie.find(param name="comment" value="{#movie_id}")
    if @comment.update(comment_params)
      if request.path.include?("/ja")
      # redirect_to root_url
        @comment.save
        flash[:success] = "レビューが更新されました。"
        redirect_to "/ja/movies/#{@comment.movie_id}"
      else
        @comment.save
        flash[:success] = "Review updated!"
        redirect_to "/en/movies/#{@comment.movie_id}"
      end
    else
      render :edit
    end
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:content, :movie_id)
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
