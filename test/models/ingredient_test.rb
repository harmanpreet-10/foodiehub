
require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test "ingredient must have a name" do
    ingredient = Ingredient.new

    assert_not ingredient.valid?
    assert_includes ingredient.errors[:name], "can't be blank"
  end

  test "ingredient name must be unique" do
    Ingredient.create!(name: "Unique Test Garlic")

    duplicate = Ingredient.new(name: "Unique Test Garlic")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "ingredient has many recipe ingredients" do
    association = Ingredient.reflect_on_association(:recipe_ingredients)

    assert_equal :has_many, association.macro
    assert_equal :destroy, association.options[:dependent]
  end

  test "ingredient has many recipes through recipe ingredients" do
    association = Ingredient.reflect_on_association(:recipes)

    assert_equal :has_many, association.macro
    assert_equal :recipe_ingredients, association.options[:through]
  end
end
