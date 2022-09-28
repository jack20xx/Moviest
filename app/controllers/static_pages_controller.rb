class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @comment    = current_user.comments.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def guest_user
    current_user == User.find_by(email: 'guest@example.com')
  end
  
  def help
  end
  
  def about
  end
  
  def contact
  end
  
end
