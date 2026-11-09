# 🍽️ FoodieHub — Recipe Explorer

**A Ruby on Rails Recipe Discovery Application**

FoodieHub is a full-stack web application built with Ruby on Rails. It allows users to discover food and drink recipes, search by recipe name or ingredient, explore recipe categories, and view detailed cooking instructions.

The application uses real-world recipe data collected from TheMealDB and TheCocktailDB APIs and stores the information in a relational database.

## 1. Project Overview

FoodieHub was developed as part of a Ruby on Rails web development project at Red River College Polytechnic.

The main objective is to demonstrate full-stack web development skills, including MVC architecture, database modeling, ActiveRecord associations, data validation, API integration, search functionality, pagination, responsive design, and automated testing.

### Project Objectives

- Develop a functional recipe discovery website using Ruby on Rails.
- Retrieve and store recipe data from multiple external APIs.
- Design a relational database with meaningful model associations.
- Implement recipe searching and category filtering.
- Provide detailed recipe information, including ingredients and instructions.
- Implement pagination for large datasets.
- Create a responsive and user-friendly interface.
- Follow version control practices using Git and GitHub.
- Validate application functionality through automated tests.

## 2. Main Features

### Homepage

The homepage introduces FoodieHub and provides quick access to recipes and categories.

It includes:

- Application introduction and navigation.
- Total recipe, category, and ingredient counts.
- Featured recipes.
- Food and drink category navigation.
- Links to the complete recipe collection.

### Recipe Explorer

Users can browse recipes imported from external APIs.

Each recipe card displays:

- Recipe image.
- Recipe title.
- Recipe category.
- A button to view the complete recipe.

### Recipe Search

Users can search recipes using a keyword.

The search supports:

- Recipe title matching.
- Ingredient name matching.
- Partial keyword matching.
- Combined searching and category filtering.

### Category Filtering

Users can filter recipes by category and explore category-specific recipe collections.

The application supports food and drink categories, including vegetarian recipes and beverages.

### Recipe Details

Each recipe has a dedicated details page containing:

- Recipe title.
- Recipe image.
- Associated category.
- Ingredient names.
- Ingredient quantities or measurements.
- Preparation instructions.
- Navigation back to the recipe collection.

### Pagination

Recipe listings are paginated to improve navigation and performance.

Pagination allows users to:

- Move between recipe pages.
- Navigate to the next or previous page.
- Access the first or last page.
- Browse large collections without loading every recipe simultaneously.

### About Page

The About page explains the application's purpose, features, and external data sources.

The project also includes an Entity Relationship Diagram (ERD) documenting the database structure.

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Ruby | Backend programming language |
| Ruby on Rails | Web application framework |
| ActiveRecord | Database operations and associations |
| SQLite | Relational database |
| HTML / ERB | Dynamic page templates |
| CSS | Application styling |
| Bootstrap | Responsive interface components |
| Kaminari | Recipe pagination |
| REST APIs | External recipe data integration |
| Git | Version control |
| GitHub | Source code repository |
| Minitest | Automated application testing |
| Visual Studio Code | Development environment |

## 4. External API Sources

FoodieHub integrates recipe information from two external data sources.

### TheMealDB

Website: https://www.themealdb.com/

TheMealDB provides food recipe information, including recipe names, images, ingredients, measurements, categories, and cooking instructions.

### TheCocktailDB

Website: https://www.thecocktaildb.com/

TheCocktailDB provides drink recipes, including beverage names, images, ingredients, measurements, and preparation instructions.

### Data Integration

Recipe information is retrieved from the APIs, transformed into application records, and stored in the local database.

Storing the imported data locally allows the application to use ActiveRecord queries for searching, filtering, and displaying recipes.

## 5. Database Design

FoodieHub uses four main ActiveRecord models.

### Category

Represents a recipe category.

Attributes include:

- `name`
- `description`

Associations:

- `has_many :recipes`

Validations:

- Category name must be present and unique.
- Description must be present.

### Recipe

Represents an individual food or drink recipe.

Attributes include:

- `title`
- `instructions`
- `image_url`
- `category_id`

Associations:

- `belongs_to :category`
- `has_many :recipe_ingredients`
- `has_many :ingredients, through: :recipe_ingredients`

Validations:

- Title must be present and unique.
- Instructions must be present.
- Image URL must be present.

### Ingredient

Represents an ingredient used in recipes.

Attributes include