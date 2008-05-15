require File.dirname(__FILE__) + '/../test_helper'

class CalculationsTest < ActiveSupport::TestCase
  fixtures :posts, :comments
  
  #
  # count
  #
  
  def test_count
    assert_equal 1, Post.count
    assert_equal 2, Comment.count
  end
  
  def test_count_with_conditions
    assert_equal 1, Post.count(:conditions => "1=1")
    assert_equal 2, Comment.count(:conditions => "1=1")
  end
  
  

end