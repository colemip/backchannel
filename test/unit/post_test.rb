require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
#  test "user logged in" do
#    assert session[:user_id]
#  end

  test "invalid with empty attributes" do
    post = Post.new
    assert !post.valid?
    assert post.errors.invalid?(:title)
    assert post.errors.invalid?(:body)
    assert post.errors.invalid?(:user_id)
  end
  
  test "positive user id" do
    post = Post.new(:title => "MyTitle", :body => "MyBody")
    
    post.user_id = -1    
    assert !post.valid?
    assert_equal "Cannot be less than 1", post.errors.on(:user_id)
    
    post.user_id = 0  
    assert !post.valid?
    assert_equal "Cannot be less than 1", post.errors.on(:user_id)
    
    post.user_id = 1
    assert post.valid?
  end
     
  
end
