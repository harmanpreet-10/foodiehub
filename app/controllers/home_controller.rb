
class HomeController < ApplicationController
  def index
    # Homepage statistics
    @recipe_count = Recipe.count
    @category_count = Category.count
    @ingredient_count = Ingredient.count

    # Featured recipes with their categories
    @featured_recipes = Recipe.includes(:category)
                              .order(:id)
                              .limit(3)

    # Categories for navigation
    @categories = Category.order(:name)

    # Featured category links
    @vegetarian_category = Category.find_by(name: "Vegetarian")
    @drinks_category = Category.find_by(name: "Drinks")
  end

  def about
  end
end
