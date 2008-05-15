require File.dirname(__FILE__) + '/../test_helper'

class OptionsTest < ActiveSupport::TestCase

  #
  # options_excluding_deleted
  #

  def test_options_excluding_deleted_no_options
    expected_default = { :conditions => "deleted_at IS NULL" }
    assert_equal expected_default, IndestructiblePost.options_excluding_deleted(Hash.new)
    assert_equal expected_default, IndestructiblePost.options_excluding_deleted(nil)
  end
  
  def test_options_excluding_deleted_no_conditions
    expected_default = { :conditions => "deleted_at IS NULL" }
    
    expected_with_order = expected_default.clone
    expected_with_order[:order] = "id DESC"
    assert_equal expected_with_order, IndestructiblePost.options_excluding_deleted({ :order => "id DESC" })
    
    expected_with_group = expected_default.clone
    expected_with_group[:group] = "title"
    assert_equal expected_with_group, IndestructiblePost.options_excluding_deleted({ :group => "title" })
  end
  
  def test_options_excluding_deleted_with_string_conditions
    expected = { :conditions => "deleted_at IS NULL AND 1=1" }
    
    assert_equal expected, IndestructiblePost.options_excluding_deleted({ :conditions => "1=1" })
  end
  
  def test_options_excluding_deleted_with_array_conditions
    expected = { :conditions => ["deleted_at IS NULL AND 1=?","fried chicken"] }
    
    assert_equal expected, IndestructiblePost.options_excluding_deleted({ :conditions => ["1=?","fried chicken"] })
  end
  
  def test_options_excluding_deleted_with_string_conditions_and_deleted_at
    #investigate: redundant but harmless? do databases optimize this out anyway?
    expected = { :conditions => "deleted_at IS NULL AND deleted_at IS NULL AND 1=1" }
    
    assert_equal expected, IndestructiblePost.options_excluding_deleted({ :conditions => "deleted_at IS NULL AND 1=1" })
  end
  
  def test_options_excluding_deleted_with_array_conditions_and_deleted_at
    #investigate: redundant but harmless? do databases optimize this out anyway?
    expected = { :conditions => ["deleted_at IS NULL AND deleted_at IS NULL AND 1=?","fried chicken"] }
    
    assert_equal expected, IndestructiblePost.options_excluding_deleted({ :conditions => ["deleted_at IS NULL AND 1=?","fried chicken"] })
  end

end