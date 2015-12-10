require "test_helper"

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "John", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef should raise error when name is not present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "name length should not exceed 40 characters" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "name length should exceed 3 characters" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end
  
  test "chef should raise error when email is not present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should not exceed 100 characters" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "valid email should not raise any error" do
    valid_adresses = %w[user@aaa.com r_tdd-ds@hello.com user@example.com first.last@aaa.com]
    valid_adresses.each do |address|
      @chef.email = address
      assert @chef.valid?, "#{address.inspect} should be valid"
    end
  end
  
  test "invalid email should raise an error" do
    valid_adresses = %w[user@aaa,com user_at_hello.com user@example. first.last@aaa+bbb.com]
    valid_adresses.each do |address|
      @chef.email = address
      assert_not @chef.valid?, "#{address.inspect} should not be valid"
    end
  end

  test "email should be saved as lowercase" do
    @chef.email = "TEST@UpperCase.com"
    @chef.save
    assert @chef.email.eql? "test@uppercase.com"
  end
  
end