
require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create!(
      name: "Test Breakfast",
      description: "Breakfast recipes for testing"
    )

    @other_category = Category.create!(
      name: "Test Dinner",
      description: "Dinner recipes for testing"
    )

    15.times do |i|
      Recipe.create!(
        title: "Breakfast Recipe #{i + 1}",
        instructions: "Prepare and cook the ingredients.",
        image_url: "https://example.com/breakfast.jpg",
        category: @category
      )
    end

    Recipe.create!(
      title: "Dinner Recipe",
      instructions: "Prepare dinner.",
      image_url: "https://example.com/dinner.jpg",
      category: @other_category
    )
  end

  test "category page loads successfully" do
    get category_path(@category)

    assert_response :success
    assert_select "h1", text: /Test Breakfast Recipes/
  end

  test "category description appears" do
    get category_path(@category)

    assert_response :success
    assert_select "p", text: /Breakfast recipes for testing/
  end

  test "category displays correct recipe count" do
    get category_path(@category)

    assert_response :success
    assert_select "p", text: /15 recipes available/
  end

  test "category shows only its own recipes" do
    get category_path(@category)

    assert_response :success
    assert_select "h5.card-title", text: "Dinner Recipe", count: 0
    assert_select "h5.card-title", text: /Breakfast Recipe/, minimum: 1
  end

  test "category pagination displays first page" do
    get category_path(@category)

    assert_response :success
    assert_select ".card", count: 12
  end

  test "category pagination displays second page" do
    get category_path(@category), params: { page: 2 }

    assert_response :success
    assert_select ".card", count: 3
  end

  test "back to recipes button exists" do
    get category_path(@category)

    assert_response :success
    assert_select "a[href='#{recipes_path}']", text: /Back to All Recipes/
  end
end
