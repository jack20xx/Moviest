class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @comment    = current_user.comments.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
      if request.path.include?("/ja/ja") or request.path.include?("/en/en")
        redirect_to root_url
      end
    end
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
