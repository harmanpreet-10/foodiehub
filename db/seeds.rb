
require "net/http"
require "json"
require "uri"

puts "Importing FoodieHub recipes..."

def fetch_json(url)
  response = Net::HTTP.get_response(URI(url))
  raise "API error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def save_recipe(item, category_name, drink: false)
  title = item["strMeal"] || item["strDrink"]
  instructions = item["strInstructions"]
  image = item["strMealThumb"] || item["strDrinkThumb"]

  return if title.blank? || instructions.blank? || image.blank?

  category = Category.find_or_create_by!(name: category_name) do |c|
    c.description = "FoodieHub #{category_name} recipes"
  end

  recipe = Recipe.find_or_initialize_by(title: title)
  recipe.category = category
  recipe.instructions = instructions
  recipe.image_url = image
  recipe.save!

  (1..15).each do |i|
    ingredient_name = item["strIngredient#{i}"]&.strip
    next if ingredient_name.blank?

    ingredient = Ingredient.find_or_create_by!(name: ingredient_name)

    quantity = item["strMeasure#{i}"]&.strip
    quantity = "As needed" if quantity.blank?

    link = RecipeIngredient.find_or_initialize_by(
      recipe: recipe,
      ingredient: ingredient
    )
    link.quantity = quantity
    link.save!
  end
end

# Import food recipes
("a".."z").each do |letter|
  data = fetch_json(
    "https://www.themealdb.com/api/json/v1/1/search.php?f=#{letter}"
  )

  (data["meals"] || []).each do |meal|
    save_recipe(meal, meal["strCategory"] || "Food")
  end
end

# Import drinks
("a".."z").each do |letter|
  data = fetch_json(
    "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
  )

  (data["drinks"] || []).each do |drink|
    save_recipe(drink, "Drinks", drink: true)
  end
end

puts "Import completed!"
puts "Categories: #{Category.count}"
puts "Recipes: #{Recipe.count}"
puts "Ingredients: #{Ingredient.count}"
puts "Recipe Ingredients: #{RecipeIngredient.count}"
puts "Total rows: #{Category.count + Recipe.count + Ingredient.count + RecipeIngredient.count}"
