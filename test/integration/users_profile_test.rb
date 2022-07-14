require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:michael)
  end
  
  test "profile display" do
    get login_path
    post login_path, params: { session: { email: @user.email, 
                                          password: 'password' } }
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.comments.count.to_s, response.body
    assert_select 'div.pagination'
    @user.comments.paginate(page: 1).each do |comment|
      assert_match comment.content, response.body
    end
    # assert_select @user.comments.count
    # assert_match @user.active_relationships.to_s, response.body
    # assert_match @user.passive_relationships.to_s, response.body
  end
end