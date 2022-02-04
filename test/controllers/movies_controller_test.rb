require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Moviest"
  end
  
  test "should get search" do
    get search_path
    assert_response :success
    assert_select "title", "Search | #{@base_title}"
  end

  # test "should get show" do
  #   get show_path
  #   assert_response :success
  #   assert_select "title", "Information | #{@base_title}"
  # end

end
