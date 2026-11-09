
require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create!(
      name: "Test Breakfast",
      description: "Breakfast recipes"
    )

    @other_category = Category.create!(
      name: "Test Dinner",
      description: "Dinner recipes"
    )

    @recipe = Recipe.create!(
      title: "Special Pancakes",
      instructions: "Mix and cook",
      image_url: "https://example.com/pancakes.jpg",
      category: @category
    )

    @other_recipe = Recipe.create!(
      title: "Special Pasta",
      instructions: "Boil pasta",
      image_url: "https://example.com/pasta.jpg",
      category: @other_category
    )

    @ingredient = Ingredient.create!(name: "Maple Syrup")

    RecipeIngredient.create!(
      recipe: @recipe,
      ingredient: @ingredient,
      quantity: "2 tbsp"
    )
  end

  test "recipes index page loads" do
    get recipes_path

    assert_response :success
    assert_select "h1", text: /Explore FoodieHub Recipes/
  end

  test "search recipes by title" do
    get recipes_path, params: { search: "Pancakes" }

    assert_response :success
    assert_select "h5.card-title", text: "Special Pancakes"
    assert_select "h5.card-title", text: "Special Pasta", count: 0
  end

  test "search recipes by ingredient" do
    get recipes_path, params: { search: "Maple Syrup" }

    assert_response :success
    assert_select "h5.card-title", text: "Special Pancakes"
    assert_select "h5.card-title", text: "Special Pasta", count: 0
  end

  test "filter recipes by category" do
    get recipes_path, params: { category_id: @category.id }

    assert_response :success
    assert_select "h5.card-title", text: "Special Pancakes"
    assert_select "h5.card-title", text: "Special Pasta", count: 0
  end

  test "combine search and category filters" do
    get recipes_path,
        params: {
          search: "Pancakes",
          category_id: @category.id
        }

    assert_response :success
    assert_select "h5.card-title", text: "Special Pancakes"
  end

  test "no results message appears" do
    get recipes_path, params: { search: "XYZNoRecipe999" }

    assert_response :success
    assert_select "h3", text: "No Recipes Found"
  end

  test "recipe detail page loads" do
    get recipe_path(@recipe)

    assert_response :success
    assert_select "h1", text: "Special Pancakes"
    assert_select "li.list-group-item", text: /Maple Syrup/
  end

  test "recipes are paginated" do
    get recipes_path

    assert_response :success
    assert_select "h5.card-title", count: 2
  end
end
