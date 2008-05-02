require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts
  
  def test_fixtures
    assert posts(:deleted).valid?
    assert posts(:hello).valid?
  end
  
end
