require File.dirname(__FILE__) + '/../test_helper'

class DeleteTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts, :indestructible_comments
  
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
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    
    assert_raises(RuntimeError) {
      IndestructiblePost.delete_all
    }

    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
  def test_delete_all_with_conditions_not_allowed
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    
    assert_raises(RuntimeError) {
      IndestructiblePost.delete_all("1=1")
    }

    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
  end
  
end