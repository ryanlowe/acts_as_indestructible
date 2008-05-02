require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :posts, :comments
  
  def test_fixtures
    assert comments(:goodbye).valid?
    assert comments(:deleted).valid?
    assert comments(:parent).valid?
    
    assert_equal posts(:hello),   comments(:goodbye).post
    assert_equal posts(:hello),   comments(:deleted).post
    assert_equal posts(:deleted), comments(:parent).post
  end
end
