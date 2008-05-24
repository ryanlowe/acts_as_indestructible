require File.dirname(__FILE__) + '/../test_helper'

class CalculationsTest < ActiveSupport::TestCase
  fixtures :indestructible_posts, :indestructible_comments
  
  #
  # count
  #
  
  def test_count
    assert_equal 3, IndestructiblePost.count
    assert_equal 2, IndestructibleComment.count
  end
  
  def test_count_with_conditions
    assert_equal 3, IndestructiblePost.count(:conditions => "1=1")
    assert_equal 2, IndestructibleComment.count(:conditions => "1=1")
  end

end