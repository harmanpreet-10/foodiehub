
class Recipe < ApplicationRecord
  belongs_to :category

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, presence: true, uniqueness: true
  validates :instructions, presence: true
  validates :image_url, presence: true
end
