require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Moviest"
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end
  
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "#{I18n.t('views.static_pages.help.title')} | #{@base_title}"
  end
  
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "#{I18n.t('views.static_pages.about.title')} | #{@base_title}"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "#{I18n.t('views.static_pages.contact.title')} | #{@base_title}"
  end
end
