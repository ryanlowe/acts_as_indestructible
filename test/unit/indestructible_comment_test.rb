require File.dirname(__FILE__) + '/../test_helper'

class IndestructibleCommentTest < ActiveSupport::TestCase
  fixtures :indestructible_posts, :indestructible_comments
  
  def test_fixtures
    assert indestructible_comments(:goodbye).valid?
    assert indestructible_comments(:deleted).valid?
    assert indestructible_comments(:deleted_post).valid?
    
    assert_equal indestructible_posts(:hello),   indestructible_comments(:goodbye).post
    assert_equal indestructible_posts(:hello),   indestructible_comments(:deleted).post
    assert_equal indestructible_posts(:deleted), indestructible_comments(:deleted_post).post
  end
end
