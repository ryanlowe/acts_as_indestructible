require File.dirname(__FILE__) + '/../test_helper'

class DestroyTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts, :indestructible_comments
  
  #
  # destroy
  #
  
  def test_destroy
    assert !indestructible_posts(:hello).destroyed?
    
    indestructible_posts(:hello).destroy(indestructible_users(:ryanlowe))
    
    assert  indestructible_posts(:hello).destroyed?
  end
  
  def test_destroy_already_destroyed
    assert indestructible_posts(:deleted).destroyed?
    time = indestructible_posts(:deleted)[:deleted_at]
    assert_not_nil time
    
    indestructible_posts(:deleted).destroy(indestructible_users(:ryanlowe))
    
    assert indestructible_posts(:deleted).destroyed?
    assert_equal time, indestructible_posts(:deleted)[:deleted_at]
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
  
  #
  # destroy_all(user, conditions = nil)
  #
  
  def test_destroy_all
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    IndestructiblePost.destroy_all(indestructible_users(:ryanlowe))
    
    assert  indestructible_posts(:deleted).reload.destroyed?
    assert  indestructible_posts(:hello).reload.destroyed?
  end
  
  def test_destroy_all_with_conditions
    #TODO:
  end
  
  def test_destroy_all_nil_user
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    IndestructiblePost.destroy_all(nil)
    
    assert  indestructible_posts(:deleted).reload.destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
  def test_destroy_all_not_user
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    IndestructiblePost.destroy_all(Object.new)
    
    assert  indestructible_posts(:deleted).reload.destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
end