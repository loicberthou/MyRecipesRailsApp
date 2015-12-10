require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "Bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "Chicken parm", summary: "The best chicken parm recipe",
              description: "heat oil, add onion, add tomato sauce, add chicken, cook for 20 minutes")
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "recipe can't have a nil chef_id" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "recipe should raise error when name is not present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length should not exceed 100 characters" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "name length should exceed 5 characters" do
    @recipe.name = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "recipe should raise error when summary is not present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end
  
  test "summary length should not exceed 150 characters" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  
  test "summary length should exceed 10 characters" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  test "recipe should raise error when description is not present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description length should not exceed 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "description length should exceed 20 characters" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
  
end