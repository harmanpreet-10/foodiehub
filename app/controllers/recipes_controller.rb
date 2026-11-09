
class RecipesController < ApplicationController
  def index
    @categories = Category.order(:name)

    @recipes = Recipe.includes(:category).order(:title)

    # Search recipes by title or ingredient name
    if params[:search].present?
      search_term = "%#{Recipe.sanitize_sql_like(params[:search].strip)}%"

      @recipes = @recipes.where(
        "recipes.title LIKE :term OR recipes.id IN (
          SELECT recipe_ingredients.recipe_id
          FROM recipe_ingredients
          INNER JOIN ingredients
          ON ingredients.id = recipe_ingredients.ingredient_id
          WHERE ingredients.name LIKE :term
        )",
        term: search_term
      )
    end

    # Filter recipes by selected category
    if params[:category_id].present?
      @recipes = @recipes.where(
        category_id: params[:category_id]
      )
    end

    # Display 12 recipes per page
    @recipes = @recipes.page(params[:page]).per(12)
  end

  def show
    @recipe = Recipe.includes(
      :category,
      recipe_ingredients: :ingredient
    ).find(params[:id])
  end
end
