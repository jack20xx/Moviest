class Movie < ApplicationRecord
  include HTTParty
  self.primary_key = "id"
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  

  default_options.update(verify: false) # disable SSL verification(必要に応じて)
  default_params api_key: 'b8bb3dcba4118e40c8c7d59fa5dc78c6', language: "ja-JP" #共通パラメタ                 
  format :json

  # キーワードによる検索機能
  # https://developers.themoviedb.org/3/search/search-keywordsに参照
  def self.search term
    base_uri 'https://api.themoviedb.org/3/search/movie'
    get("", query: { query: term}) # {}の中身はパラメタ
  end

  # 指定の映画の詳細情報を取得
  # https://developers.themoviedb.org/3/movies/get-movie-detailsに参照
  def self.details id
    #base_uri "https://api.themoviedb.org/3/movie/#{id}"
    get("https://api.themoviedb.org/3/movie/#{id}", query: {} ) #パラメタなし
  end
  
  # def self.popular(page=1)
  #   base_uri 'https://api.themoviedb.org/3/movie/popular'
  #   get("", query: { language: 'ja-JP', region: "JP" })
  # end
end