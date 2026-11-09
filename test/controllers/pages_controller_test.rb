
require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "about page loads successfully" do
    get home_about_path
    assert_response :success
  end

  test "about page displays FoodieHub information" do
    get home_about_path
    assert_response :success
    assert_select "body", text: /FoodieHub/i
  end
end
