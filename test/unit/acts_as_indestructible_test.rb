require File.dirname(__FILE__) + '/../test_helper'

class ActsAsIndestructibleTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts, :indestructible_comments
  
  def test_fixtures_destroyed?
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    assert !indestructible_comments(:goodbye).destroyed?
    assert  indestructible_comments(:destroyed).destroyed?
    assert !indestructible_comments(:destroyed_post).destroyed?
  end
  
end