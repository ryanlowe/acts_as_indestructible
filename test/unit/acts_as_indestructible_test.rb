require File.dirname(__FILE__) + '/../test_helper'

class ActsAsIndestructibleTest < Test::Unit::TestCase
  fixtures :indestructible_posts, :indestructible_comments
  
  def test_fixtures_destroyed?
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    assert !indestructible_comments(:goodbye).destroyed?
    assert  indestructible_comments(:deleted).destroyed?
    assert !indestructible_comments(:deleted_post).destroyed?
  end
  
  #
  # destroy
  #
  
  def test_destroy
    assert !indestructible_posts(:hello).destroyed?
    
    indestructible_posts(:hello).destroy
    
    assert  indestructible_posts(:hello).destroyed?
  end
  
  def test_destroy_already_destroyed
    assert indestructible_posts(:deleted).destroyed?
    time = indestructible_posts(:deleted)[:deleted_at]
    assert_not_nil time
    
    indestructible_posts(:deleted).destroy
    
    assert indestructible_posts(:deleted).destroyed?
    assert_equal time, indestructible_posts(:deleted)[:deleted_at]
  end
  
  def test_destroy_all
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    
    IndestructiblePost.destroy_all
    
    assert  indestructible_posts(:deleted).reload.destroyed?
    assert  indestructible_posts(:hello).reload.destroyed?
  end
  
  #
  # delete
  #
  
  def test_delete_not_allowed
    assert !indestructible_posts(:hello).destroyed?
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    
    assert_raises(RuntimeError) {
      IndestructiblePost.delete(indestructible_posts(:hello).id)
    }

    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
  def test_delete_all_not_allowed
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    
    assert_raises(RuntimeError) {
      IndestructiblePost.delete_all
    }

    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    assert  indestructible_posts(:deleted).destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
end