require File.dirname(__FILE__) + '/../test_helper'

class ActsAsIndestructibleTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts, :indestructible_comments
  
  def test_fixtures_destroyed?
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    assert !indestructible_comments(:goodbye).destroyed?
    assert  indestructible_comments(:deleted).destroyed?
    assert !indestructible_comments(:deleted_post).destroyed?
  end
  
end