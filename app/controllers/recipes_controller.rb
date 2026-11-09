
class RecipesController < ApplicationController
  def index
    @categories = Category.order(:name)
    @recipes = Recipe.includes(:category).order(:title)

    if params[:search].present?
      @recipes = @recipes.where(
        "title LIKE ?", "%#{params[:search]}%"
      )
    end

    if params[:category_id].present?
      @recipes = @recipes.where(
        category_id: params[:category_id]
      )
    end

    @recipes = @recipes.page(params[:page]).per(12)
  end

  def show
    @recipe = Recipe.includes(:category, :recipe_ingredients, :ingredients)
                    .find(params[:id])
  end
end
