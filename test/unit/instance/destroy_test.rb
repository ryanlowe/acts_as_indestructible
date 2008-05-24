require File.dirname(__FILE__) + '/../../test_helper'

class DestroyTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts
  
  #
  # destroy
  #
  
  def test_destroy
    assert !indestructible_posts(:hello).destroyed?
    
    indestructible_posts(:hello).destroy(indestructible_users(:ryanlowe))
    
    assert  indestructible_posts(:hello).destroyed?
  end
  
  def test_destroy_already_destroyed
    assert indestructible_posts(:destroyed).destroyed?
    time = indestructible_posts(:destroyed)[:destroyed_at]
    assert_not_nil time
    
    indestructible_posts(:destroyed).destroy(indestructible_users(:ryanlowe))
    
    assert indestructible_posts(:destroyed).destroyed?
    assert_equal time, indestructible_posts(:destroyed)[:destroyed_at]
  end
  
  def test_destroy_nil_user
    assert !indestructible_posts(:hello).destroyed?
    
    indestructible_posts(:hello).destroy(nil)
    
    assert !indestructible_posts(:hello).destroyed?
  end
  
  def test_destroy_not_user
    assert !indestructible_posts(:hello).destroyed?
    
    indestructible_posts(:hello).destroy(Object.new)
    
    assert !indestructible_posts(:hello).destroyed?
  end
  
end