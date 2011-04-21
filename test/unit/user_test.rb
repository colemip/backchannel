require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end
  
  test "invalid with empty attributes" do
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:login)
    assert user.errors.invalid?(:first_name)
    assert user.errors.invalid?(:last_name)
    assert user.errors.invalid?(:email)
    assert user.errors.invalid?(:pw)
  end
  
end
