class ApplicationController < ActionController::Base
  before_action :set_request
  protect_from_forgery with: :exception
  include SessionsHelper


  def set_request
    Thread.current[:request] = request
  end
  
  # ロケール振り分けを全てのアクションで実行
  around_action :switch_locale

  # params値のロケールによる振り分け
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
 
  # url_for関係メソッドでロケールを設定するよう上書き
  def default_url_options
    { locale: I18n.locale }
  end
  
  # before_action :set_locale
  
  # def set_locale
  #   I18n.locale = locale
  # end
  
  # def locale
  #   @locale ||= params[:locale] ||= I18n.default_locale
  # end
  
  # def default_url_options(options={})
  #   options.merge(locale: locale)
  # end
  
  # def add_movies_to_db movies
  #   movies.each do |m|
  #     unless Movie.exists?(m["id"])
  #       Movie.add(m["id"])
  #     end
  #   end
  # end
  
  # def add_movies_to_db movies
  #   @movies = []
  #   @movie_info = Movie.details(params[:id])
    
  #   if @movie_info.present?
  #     results = @movie_info
  #     results.each do |result|
  #       movie = Movie.new(data(result))
  #       @movies << movie
  #     end
  #   end
    
  #   @movies.each do |movie|
  #     unless Movie.all.include?(movie)
  #       movie.save
  #     end
  #   end
  # end
  
  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t('controllers.application_controller.danger')
        redirect_to login_url
      end
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
