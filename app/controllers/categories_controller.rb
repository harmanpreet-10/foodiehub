
class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])

    @recipes = @category.recipes
                        .order(:title)
                        .page(params[:page])
                        .per(12)
  end
end
