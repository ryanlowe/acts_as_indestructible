require File.dirname(__FILE__) + '/../../test_helper'

class ExistsTest < ActiveSupport::TestCase
  fixtures :indestructible_posts
  
  #
  # regular behaviour
  #
  
  def test_exists_integer
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id)
  end
  
  def test_exists_string
    assert IndestructiblePost.exists?(indestructible_posts(:hello).id.to_s)
  end
  
  def test_exists_integer_does_not_exist
    assert !IndestructiblePost.exists?(9999)
  end
  
  def test_exists_string_does_not_exist
    assert !IndestructiblePost.exists?('9999')
  end
  
  ## API note: cannot pass conditions as a plain string
  
  def test_exists_with_hash_conditions
    assert  IndestructiblePost.exists?(:title => 'Hello World!')
    assert !IndestructiblePost.exists?(:title => 'n0ns3ns3')
  end
  
  def test_exists_with_array_conditions
    assert  IndestructiblePost.exists?(['title = ?','Hello World!'])
    assert !IndestructiblePost.exists?(['title = ?','n0ns3ns3'])
  end
  
  #
  # implicitly excluding destroyed
  #
  
  def test_exists_destroyed_integer
    assert !IndestructiblePost.exists?(indestructible_posts(:destroyed).id)
  end
  
  def test_exists_destroyed_string
    assert !IndestructiblePost.exists?(indestructible_posts(:destroyed).id.to_s)
  end
  
  def test_exists_destroyed_with_hash_conditions
    assert !IndestructiblePost.exists?(:title => 'Destroyed Post')
  end
  
  def test_exists_destroyed_with_array_conditions
    assert !IndestructiblePost.exists?(['title = ?','Destroyed Post'])
  end
  
  #
  # explicitly excluding destroyed
  #
  
  def test_exists_excluding_destroyed_integer
    assert !IndestructiblePost.exists?(indestructible_posts(:destroyed).id, :include_destroyed => false)
  end
  
  def test_exists_excluding_destroyed_string
    assert !IndestructiblePost.exists?(indestructible_posts(:destroyed).id.to_s, :include_destroyed => false)
  end
  
  def test_exists_excluding_destroyed_with_hash_conditions
    assert !IndestructiblePost.exists?(:title => 'Destroyed Post', :include_destroyed => false)
  end
  
  def test_exists_excluding_destroyed_with_array_conditions
    assert !IndestructiblePost.exists?(['title = ?','Destroyed Post'], :include_destroyed => false)
  end
  
  #
  # including destroyed
  #
  
  def test_exists_including_destroyed_integer
    assert IndestructiblePost.exists?(indestructible_posts(:destroyed).id, :include_destroyed => true)
  end
  
  def test_exists_including_destroyed_string
    assert IndestructiblePost.exists?(indestructible_posts(:destroyed).id, :include_destroyed => true)
  end
  
  def test_exists_including_destroyed_with_hash_conditions
    assert IndestructiblePost.exists?(:title => 'Destroyed Post', :include_destroyed => true)
  end
  
  def test_exists_including_destroyed_with_array_conditions
    assert IndestructiblePost.exists?(['title = ?','Destroyed Post'], :include_destroyed => true)
  end
  
end