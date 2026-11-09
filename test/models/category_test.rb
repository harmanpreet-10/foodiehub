
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "category must have a name" do
    category = Category.new(description: "Delicious recipes")

    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "category must have a description" do
    category = Category.new(name: "Test Category")

    assert_not category.valid?
    assert_includes category.errors[:description], "can't be blank"
  end

  test "category name must be unique" do
    Category.create!(
      name: "Unique Test Category",
      description: "First category"
    )

    duplicate = Category.new(
      name: "Unique Test Category",
      description: "Second category"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "category has many recipes association" do
    assert_includes Category.reflect_on_all_associations(:has_many)
                            .map(&:name), :recipes
  end
end
