
require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(
      name: "Test Meals",
      description: "Recipes for testing"
    )
  end

  test "recipe must have a title" do
    recipe = Recipe.new(
      category: @category,
      instructions: "Mix ingredients",
      image_url: "https://example.com/food.jpg"
    )

    assert_not recipe.valid?
    assert_includes recipe.errors[:title], "can't be blank"
  end

  test "recipe must have instructions" do
    recipe = Recipe.new(
      title: "Test Pasta",
      category: @category,
      image_url: "https://example.com/food.jpg"
    )

    assert_not recipe.valid?
    assert_includes recipe.errors[:instructions], "can't be blank"
  end

  test "recipe must have an image URL" do
    recipe = Recipe.new(
      title: "Test Pasta",
      category: @category,
      instructions: "Cook for 10 minutes"
    )

    assert_not recipe.valid?
    assert_includes recipe.errors[:image_url], "can't be blank"
  end

  test "recipe title must be unique" do
    Recipe.create!(
      title: "Unique Test Pasta",
      category: @category,
      instructions: "Cook pasta",
      image_url: "https://example.com/food.jpg"
    )

    duplicate = Recipe.new(
      title: "Unique Test Pasta",
      category: @category,
      instructions: "Boil pasta",
      image_url: "https://example.com/food2.jpg"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:title], "has already been taken"
  end

  test "recipe belongs to category" do
    association = Recipe.reflect_on_association(:category)

    assert_equal :belongs_to, association.macro
  end

  test "recipe has many ingredients through recipe ingredients" do
    association = Recipe.reflect_on_association(:ingredients)

    assert_equal :has_many, association.macro
    assert_equal :recipe_ingredients, association.options[:through]
  end
end
