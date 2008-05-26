require File.dirname(__FILE__) + '/../../test_helper'

class DestroyAllTest < Test::Unit::TestCase
  fixtures :indestructible_users, :indestructible_posts
  
  #
  # destroy_all(user, conditions = nil)
  #
  
  def test_destroy_all
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert !indestructible_posts(:goodbye).destroyed?
    assert !indestructible_posts(:no_body).destroyed?
    
    IndestructiblePost.destroy_all(indestructible_users(:ryanlowe))
    
    assert  indestructible_posts(:destroyed).reload.destroyed?
    assert  indestructible_posts(:hello).reload.destroyed?
    assert  indestructible_posts(:goodbye).reload.destroyed?
    assert  indestructible_posts(:no_body).reload.destroyed?
  end
  
  def test_destroy_all_with_conditions
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert !indestructible_posts(:goodbye).destroyed?
    assert !indestructible_posts(:no_body).destroyed?
    
    assert_equal 'Hello World!', indestructible_posts(:hello).title
    
    IndestructiblePost.destroy_all(indestructible_users(:ryanlowe),"title = 'Hello World!'")
    
    assert  indestructible_posts(:destroyed).reload.destroyed?
    assert  indestructible_posts(:hello).reload.destroyed?
    assert !indestructible_posts(:goodbye).reload.destroyed?
    assert !indestructible_posts(:no_body).reload.destroyed?
  end
  
  def test_destroy_all_nil_user
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert !indestructible_posts(:goodbye).destroyed?
    assert !indestructible_posts(:no_body).destroyed?
    
    IndestructiblePost.destroy_all(nil)
    
    assert  indestructible_posts(:destroyed).reload.destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
    assert !indestructible_posts(:goodbye).reload.destroyed?
    assert !indestructible_posts(:no_body).reload.destroyed?
  end
  
  def test_destroy_all_not_user
    assert  indestructible_posts(:destroyed).destroyed?
    assert !indestructible_posts(:hello).destroyed?
    assert !indestructible_posts(:goodbye).destroyed?
    assert !indestructible_posts(:no_body).destroyed?
    
    IndestructiblePost.destroy_all(Object.new)
    
    assert  indestructible_posts(:destroyed).reload.destroyed?
    assert !indestructible_posts(:hello).reload.destroyed?
    assert !indestructible_posts(:goodbye).reload.destroyed?
    assert !indestructible_posts(:no_body).reload.destroyed?
  end
  
end