require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "comment interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: "" } }
    end
    assert_select 'div#error_explanation'
    content = "This comment really ties the room together"
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    assert_select 'a', text: 'delete'
    first_comment = @user.comments.paginate(page: 1).first
    assert_difference 'Comment.count', -1 do
      delete comment_path(first_comment)
    end
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
