require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @movie = movies(:harry)
    @comment = @user.comments.build(content: "Lorem ipsum", movie_id: @movie.id)
  end
  
  test "should be valid" do
    assert @comment.valid?
  end
  
  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "movie id should be present" do
    @comment.movie_id = nil
    assert_not @comment.valid?
  end
  
  test "content should be present" do
    @comment.content = "    "
    assert_not @comment.valid?
  end
  
  test "content should be at most 250 characters" do
    @comment.content = "a" * 251
    assert_not @comment.valid?
  end
  
  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end
