require 'test_helper'

class CheerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
#  test "the truth" do
#    assert true
#  end

  test "invalid with empty attributes" do
    cheer = Cheer.new
    assert !cheer.valid?
    assert cheer.errors.invalid?(:user_id)
    assert cheer.errors.invalid?(:post_id)
  end
end
