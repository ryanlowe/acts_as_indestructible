require File.dirname(__FILE__) + '/../test_helper'

class ActsAsIndestructibleTest < Test::Unit::TestCase
  fixtures :posts
  
  def test_destroyed?
    assert  posts(:deleted).destroyed?
    assert !posts(:hello).destroyed?
  end
  
end