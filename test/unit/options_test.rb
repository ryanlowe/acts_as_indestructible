require File.dirname(__FILE__) + '/../test_helper'

class OptionsTest < ActiveSupport::TestCase

  #
  # options_excluding_destroyed
  #

  def test_options_excluding_destroyed_no_options
    expected_default = { :conditions => "indestructible_posts.destroyed_at IS NULL" }
    assert_equal expected_default, IndestructiblePost.options_excluding_destroyed(Hash.new)
    assert_equal expected_default, IndestructiblePost.options_excluding_destroyed(nil)
  end
  
  def test_options_excluding_destroyed_no_conditions
    expected_default = { :conditions => "indestructible_posts.destroyed_at IS NULL" }
    
    expected_with_order = expected_default.clone
    expected_with_order[:order] = "id DESC"
    assert_equal expected_with_order, IndestructiblePost.options_excluding_destroyed({ :order => "id DESC" })
    
    expected_with_group = expected_default.clone
    expected_with_group[:group] = "title"
    assert_equal expected_with_group, IndestructiblePost.options_excluding_destroyed({ :group => "title" })
  end
  
  def test_options_excluding_destroyed_with_string_conditions
    expected = { :conditions => "indestructible_posts.destroyed_at IS NULL AND 1=1" }
    
    assert_equal expected, IndestructiblePost.options_excluding_destroyed({ :conditions => "1=1" })
  end
  
  def test_options_excluding_destroyed_with_array_conditions
    expected = { :conditions => ["indestructible_posts.destroyed_at IS NULL AND 1=?","fried chicken"] }
    
    assert_equal expected, IndestructiblePost.options_excluding_destroyed({ :conditions => ["1=?","fried chicken"] })
  end
  
  def test_options_excluding_destroyed_with_string_conditions_and_destroyed_at
    #investigate: redundant but harmless? do databases optimize this out anyway?
    expected = { :conditions => "indestructible_posts.destroyed_at IS NULL AND destroyed_at IS NULL AND 1=1" }
    
    assert_equal expected, IndestructiblePost.options_excluding_destroyed({ :conditions => "destroyed_at IS NULL AND 1=1" })
  end
  
  def test_options_excluding_destroyed_with_array_conditions_and_destroyed_at
    #investigate: redundant but harmless? do databases optimize this out anyway?
    expected = { :conditions => ["indestructible_posts.destroyed_at IS NULL AND destroyed_at IS NULL AND 1=?","fried chicken"] }
    
    assert_equal expected, IndestructiblePost.options_excluding_destroyed({ :conditions => ["destroyed_at IS NULL AND 1=?","fried chicken"] })
  end

end