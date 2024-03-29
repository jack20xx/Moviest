require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    # post users_url, params: { user: { name: @user.name, email: @user.email } }
    # @movie = movies(:harry)
    @comment = comments(:orange)
    @locale = {locale: "ja"}
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment, @locale)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong comment" do
    log_in_as(users(:michael))
    comment = comments(:ants)
    assert_no_difference 'Comment.count' do
      delete comment_path(comment)
    end
    assert_redirected_to root_url
  end
end