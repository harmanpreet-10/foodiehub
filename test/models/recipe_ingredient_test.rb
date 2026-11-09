
require "test_helper"

class RecipeIngredientTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(
      name: "Test Cooking",
      description: "Cooking recipes for testing"
    )

    @recipe = Recipe.create!(
      title: "Test Vegetable Soup",
      instructions: "Boil vegetables",
      image_url: "https://example.com/soup.jpg",
      category: @category
    )

    @ingredient = Ingredient.create!(
      name: "Test Carrot"
    )
  end

  test "recipe ingredient must have a quantity" do
    item = RecipeIngredient.new(
      recipe: @recipe,
      ingredient: @ingredient
    )

    assert_not item.valid?
    assert_includes item.errors[:quantity], "can't be blank"
  end

  test "same ingredient cannot be added twice to one recipe" do
    RecipeIngredient.create!(
      recipe: @recipe,
      ingredient: @ingredient,
      quantity: "2 cups"
    )

    duplicate = RecipeIngredient.new(
      recipe: @recipe,
      ingredient: @ingredient,
      quantity: "3 cups"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:ingredient_id], "has already been taken"
  end

  test "recipe ingredient belongs to recipe" do
    association = RecipeIngredient.reflect_on_association(:recipe)

    assert_equal :belongs_to, association.macro
  end

  test "recipe ingredient belongs to ingredient" do
    association = RecipeIngredient.reflect_on_association(:ingredient)

    assert_equal :belongs_to, association.macro
  end

  test "valid recipe ingredient can be saved" do
    item = RecipeIngredient.new(
      recipe: @recipe,
      ingredient: @ingredient,
      quantity: "1 cup"
    )

    assert item.valid?
    assert item.save
  end
end
