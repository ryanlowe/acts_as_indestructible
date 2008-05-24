require File.dirname(__FILE__) + '/../test_helper'

class FindByIdTest < ActiveSupport::TestCase
  fixtures :indestructible_posts
  
  #
  # regular behaviour
  #
  
  def test_find_by_integer
    # Person.find(1) - returns the object for ID = 1
    a = indestructible_posts(:hello)
    assert_equal a, IndestructiblePost.find(a.id)
  end
  
  def test_find_by_integer_parameters
    # Person.find(1, 2, 6) - returns an array for objects with IDs in (1, 2, 6)
    a = indestructible_posts(:hello)
    b = indestructible_posts(:goodbye)
    c = indestructible_posts(:no_body)
    assert_equal [a,b,c], IndestructiblePost.find(a.id,b.id,c.id)
  end
  
  def test_find_by_integer_array
    # Person.find([7, 17]) - returns an array for objects with IDs in (7, 17)
    b = indestructible_posts(:goodbye)
    c = indestructible_posts(:no_body)
    assert_equal [b,c], IndestructiblePost.find([b.id,c.id])
  end
  
  def test_find_by_integer_array_of_one
    # Person.find([1]) - returns an array for the object with ID = 1
    b = indestructible_posts(:goodbye)
    assert_equal [b], IndestructiblePost.find([b.id])
  end
  
  def test_find_by_integer_with_options
    # Person.find(1, :conditions => "administrator = 1", :order => "created_on DESC")
    c = indestructible_posts(:no_body)
    assert_equal c, IndestructiblePost.find(c.id, :order => "id DESC")
  end
  
  #
  # regular behaviour -- not found
  #
  
  def test_find_by_integer_not_found
    # Person.find(1) - returns the object for ID = 1
    assert !IndestructiblePost.exists?(9999)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(9999)
    }
  end
  
  def test_find_by_integer_parameters_one_not_found
    # Person.find(1, 2, 6) - returns an array for objects with IDs in (1, 2, 6)
    assert !IndestructiblePost.exists?(9999)
    a = indestructible_posts(:hello)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(a.id,9999,c.id)
    }
  end
  
  def test_find_by_integer_array_one_not_found
    # Person.find([7, 17]) - returns an array for objects with IDs in (7, 17)
    assert !IndestructiblePost.exists?(9999)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([9999,c.id])
    }
  end
  
  def test_find_by_integer_array_of_one_not_found
    # Person.find([1]) - returns an array for the object with ID = 1
    assert !IndestructiblePost.exists?(9999)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([9999])
    }
  end
  
  def test_find_by_integer_with_options_not_found
    # Person.find(1, :conditions => "administrator = 1", :order => "created_on DESC")
    assert !IndestructiblePost.exists?(9999)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(9999, :order => "id DESC")
    }
  end
  
  #
  # implicitly excluding destroyed
  #
  
  def test_find_by_integer_not_found_implicitly_excluding_destroyed
    # Person.find(1) - returns the object for ID = 1
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(x.id)
    }
  end
  
  def test_find_by_integer_parameters_one_not_found_implicitly_excluding_destroyed
    # Person.find(1, 2, 6) - returns an array for objects with IDs in (1, 2, 6)
    a = indestructible_posts(:hello)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(a.id,x.id,c.id)
    }
  end
  
  def test_find_by_integer_array_one_not_found_implicitly_excluding_destroyed
    # Person.find([7, 17]) - returns an array for objects with IDs in (7, 17)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([x.id,c.id])
    }
  end
  
  def test_find_by_integer_array_of_one_implicitly_excluding_destroyed
    # Person.find([1]) - returns an array for the object with ID = 1
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([x.id])
    }
  end
  
  def test_find_by_integer_with_options_implicitly_excluding_destroyed
    # Person.find(1, :conditions => "administrator = 1", :order => "created_on DESC")
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(x.id, :order => "id DESC")
    }
  end
  
  #
  # explicitly excluding destroyed
  #
  
  def test_find_by_integer_not_found_excluding_destroyed
    # Person.find(1) - returns the object for ID = 1
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(x.id, :include_destroyed => false)
    }
  end
  
  def test_find_by_integer_parameters_one_not_found_excluding_destroyed
    # Person.find(1, 2, 6) - returns an array for objects with IDs in (1, 2, 6)
    a = indestructible_posts(:hello)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(a.id,x.id,c.id, :include_destroyed => false)
    }
  end
  
  def test_find_by_integer_array_one_not_found_excluding_destroyed
    # Person.find([7, 17]) - returns an array for objects with IDs in (7, 17)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([x.id,c.id], :include_destroyed => false)
    }
  end
  
  def test_find_by_integer_array_of_one_excluding_destroyed
    # Person.find([1]) - returns an array for the object with ID = 1
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find([x.id], :include_destroyed => false)
    }
  end
  
  def test_find_by_integer_with_options_excluding_destroyed
    # Person.find(1, :conditions => "administrator = 1", :order => "created_on DESC")
    x = indestructible_posts(:destroyed)
    assert_raises(ActiveRecord::RecordNotFound) {
      IndestructiblePost.find(x.id, :order => "id DESC", :include_destroyed => false)
    }
  end
  
  #
  # including destroyed
  #
  
  def test_find_by_integer_including_destroyed
    # Person.find(1) - returns the object for ID = 1
    x = indestructible_posts(:destroyed)
    assert_equal x, IndestructiblePost.find(x.id, :include_destroyed => true)
  end
  
  def test_find_by_integer_parameters_including_destroyed
    # Person.find(1, 2, 6) - returns an array for objects with IDs in (1, 2, 6)
    a = indestructible_posts(:hello)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_equal [x,a,c], IndestructiblePost.find(a.id,x.id,c.id, :include_destroyed => true)
  end
  
  def test_find_by_integer_array_including_destroyed
    # Person.find([7, 17]) - returns an array for objects with IDs in (7, 17)
    x = indestructible_posts(:destroyed)
    c = indestructible_posts(:no_body)
    assert_equal [x,c], IndestructiblePost.find([x.id,c.id], :include_destroyed => true)
  end
  
  def test_find_by_integer_array_of_one_including_destroyed
    # Person.find([1]) - returns an array for the object with ID = 1
    x = indestructible_posts(:destroyed)
    assert_equal [x], IndestructiblePost.find([x.id], :include_destroyed => true)
  end
  
  def test_find_by_integer_with_options_including_destroyed
    # Person.find(1, :conditions => "administrator = 1", :order => "created_on DESC")
    x = indestructible_posts(:destroyed)
    assert_equal x, IndestructiblePost.find(x.id, :order => "id DESC", :include_destroyed => true)
  end
  
end