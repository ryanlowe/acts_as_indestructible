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
  
end