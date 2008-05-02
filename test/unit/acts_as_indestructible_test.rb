require File.dirname(__FILE__) + '/../test_helper'

class ActsAsIndestructibleTest < Test::Unit::TestCase
  fixtures :posts, :comments
  
  def test_fixtures_destroyed?
    assert  posts(:deleted).destroyed?
    assert !posts(:hello).destroyed?
    
    assert !comments(:goodbye).destroyed?
    assert  comments(:deleted).destroyed?
    assert !comments(:parent).destroyed?
  end
  
  def test_destroy
    assert !posts(:hello).destroyed?
    
    posts(:hello).destroy
    
    assert  posts(:hello).destroyed?
  end
  
  def test_destroy_already_destroyed
    assert posts(:deleted).destroyed?
    time = posts(:deleted)[:deleted_at]
    assert_not_nil time
    
    posts(:deleted).destroy
    
    assert posts(:deleted).destroyed?
    assert_equal time, posts(:deleted)[:deleted_at]
  end
  
end