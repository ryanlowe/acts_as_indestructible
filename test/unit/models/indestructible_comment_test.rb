require File.dirname(__FILE__) + '/../../test_helper'

class IndestructibleCommentTest < ActiveSupport::TestCase
  fixtures :indestructible_posts, :indestructible_comments
  
  def test_fixtures
    assert indestructible_comments(:goodbye).valid?
    assert indestructible_comments(:destroyed).valid?
    assert indestructible_comments(:destroyed_post).valid?
    
    assert_equal indestructible_posts(:hello), indestructible_comments(:goodbye).post
    assert_equal indestructible_posts(:hello), indestructible_comments(:destroyed).post
    assert_equal nil,                          indestructible_comments(:destroyed_post).post
  end
end
